import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/price_selector.dart';
import 'package:frontend/widgets/selection_field.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SecondWidget extends StatefulWidget {
  const SecondWidget({super.key});

  @override
  State<SecondWidget> createState() => _SecondWidgetState();
}

class _SecondWidgetState extends State<SecondWidget> {
  String selectedPrice = '';
  String selectedLocation = 'Bandung';
  String selectedType = 'Rumah';

  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 12),
                      _formCard(),
                    ],
                  ),
                ),
              ],
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
            child: Image.asset('assets/img/splash_screen.png'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Search',
                style: textStyle(18, FontWeight.w600, Colors.black),
              ),
              Text(
                'Silahkan tentukan properti yang ingin diprediksi.',
                style: textStyle(12, FontWeight.w300, Colors.black),
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                SelectionField(
                  icon: LucideIcons.mapPin,
                  label: "LOKASI",
                  value: selectedLocation,
                  onTap: () {
                    // nanti jadi dropdown / API
                  },
                ),
                const SizedBox(width: 25),
                SelectionField(
                  icon: LucideIcons.house,
                  label: "TIPE",
                  value: selectedType,
                  onTap: () {
                    // nanti jadi dropdown / API
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            PriceSelector(
              selectedPrice: selectedPrice,
              onChanged: (value) {
                setState(() => selectedPrice = value);
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
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(999)),
          color: AppColors.secondcolor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.search, color: Colors.white, size: 16),
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
