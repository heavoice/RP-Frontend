import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/exceptions/unauthorized_exception.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/search_provider.dart';
import 'package:frontend/services/house_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/settings/first_capitalize.dart';
import 'package:frontend/widgets/price_selector.dart';
import 'package:frontend/widgets/selection_field.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SecondWidget extends ConsumerStatefulWidget {
  const SecondWidget({super.key});

  @override
  ConsumerState<SecondWidget> createState() => _SecondWidgetState();
}

class _SecondWidgetState extends ConsumerState<SecondWidget> {
  List<dynamic> houses = [];
  List<dynamic> filteredHouses = [];

  List<String> locations = [];
  List<String> types = [];

  String selectedPrice = '';
  String selectedLocation = 'Pilih Lokasi';
  String selectedType = 'Pilih Tipe';

  @override
  void initState() {
    super.initState();
    loadHouses();
  }

  /// PRICE MATCHER
  bool matchPriceAtt(int price) {
    switch (selectedPrice) {
      case 'Rp < 1M':
        return price < 1000000000;

      case 'Rp 1-3M':
        return price >= 1000000000 && price <= 3000000000;

      case 'Rp 3-5M':
        return price >= 3000000000 && price <= 5000000000;

      case 'Rp 5M+':
        return price > 5000000000;

      default:
        return true;
    }
  }

  /// LOAD HOUSES
  Future<void> loadHouses() async {
    try {
      final data = await HouseService.getHouses();

      if (!mounted) return;

      setState(() {
        houses = data;
        filteredHouses = data;

        locations =
            data.map<String>((e) => e['location'].toString()).toSet().toList();

        types = data
            .map<String>((e) => e['propertyType'].toString())
            .toSet()
            .toList();
      });
    } on UnauthorizedException {
      await ref.read(authProvider.notifier).logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );

      rethrow;
    } catch (e) {
      debugPrint('LOAD HOUSES ERROR: $e');
    }
  }

  /// LOCAL FILTER
  void applyFilter() {
    setState(() {
      filteredHouses = houses.where((house) {
        final matchLocation = selectedLocation.isEmpty
            ? true
            : house['location'] == selectedLocation;

        final matchType =
            selectedType.isEmpty ? true : house['propertyType'] == selectedType;

        final price = house['price'] ?? 0;

        final matchPrice = selectedPrice.isEmpty ? true : matchPriceAtt(price);

        return matchLocation && matchType && matchPrice;
      }).toList();
    });
  }

  /// BUILD QUERY PARAMS
  Map<String, dynamic> buildQueryParams() {
    int? priceMin;
    int? priceMax;

    switch (selectedPrice) {
      case 'Rp < 1M':
        priceMax = 1000000000;
        break;

      case 'Rp 1-3M':
        priceMin = 1000000000;
        priceMax = 3000000000;
        break;

      case 'Rp 3-5M':
        priceMin = 3000000000;
        priceMax = 5000000000;
        break;

      case 'Rp 5M+':
        priceMin = 5000000000;
        break;
    }

    return {
      'location':
          selectedLocation.isEmpty ? null : selectedLocation.toLowerCase(),
      'propertyType': selectedType.isEmpty ? null : selectedType.toUpperCase(),
      'priceMin': priceMin,
      'priceMax': priceMax,
    };
  }

  TextStyle textStyle(
    double size,
    FontWeight weight,
    Color color,
  ) {
    return TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(32),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth < 480 ? 300 : 400,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(218, 245, 226, 1),
                  Color.fromARGB(255, 150, 211, 170),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 12),
                  _formCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            width: 90,
            height: 90,
            child: Image.asset(
              'assets/img/splash_screen.png',
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Search',
                style: textStyle(
                  18,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                'Silahkan tentukan properti yang ingin diprediksi.',
                style: textStyle(
                  12,
                  FontWeight.w300,
                  Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formCard() {
    return Material(
      elevation: 2,
      color: const Color(0xFFF3FCF6),
      borderRadius: BorderRadius.circular(32),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// LOCATION
                SelectionField(
                  icon: LucideIcons.mapPin,
                  label: "LOKASI",
                  value: selectedLocation.isEmpty
                      ? "Bandung"
                      : capitalizeFirst(
                          selectedLocation,
                        ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ListView(
                          children: locations.map((loc) {
                            return ListTile(
                              title: Text(
                                capitalizeFirst(loc),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedLocation = loc;
                                });

                                applyFilter();

                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(width: 11),

                /// TYPE
                SelectionField(
                  icon: LucideIcons.house,
                  label: "TIPE",
                  value: selectedType.isEmpty
                      ? "House"
                      : capitalizeFirst(
                          selectedType,
                        ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ListView(
                          children: types.map((type) {
                            return ListTile(
                              title: Text(
                                capitalizeFirst(type),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedType = type;
                                });

                                applyFilter();

                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// PRICE
            PriceSelector(
              selectedPrice: selectedPrice,
              onChanged: (value) {
                setState(() {
                  selectedPrice = value;
                });

                applyFilter();
              },
            ),
            const SizedBox(height: 18),
            _button(),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return InkWell(
      onTap: () async {
        final queryParams = buildQueryParams();

        await ref.read(searchProvider.notifier).quickSearch(
              location: queryParams['location'],
              propertyType: queryParams['propertyType'],
              priceMin: queryParams['priceMin'],
              priceMax: queryParams['priceMax'],
            );
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(999),
          ),
          color: AppColors.secondcolor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.search,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              'Quick Search',
              style: TextStyle(
                fontFamily: AppFonts.primary,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
