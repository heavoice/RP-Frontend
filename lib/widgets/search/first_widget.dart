import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FirstWidget extends StatefulWidget {
  const FirstWidget({super.key});

  @override
  State<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );
  String selectedType = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(top: 42),
        constraints: BoxConstraints(
          maxWidth: screenWidth < 480 ? 300 : 400,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Aksi ketika ikon diklik
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          LucideIcons.arrowLeft,
                          color: AppColors.secondwidgetborder,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pencarian',
                            style: textStyle(12, FontWeight.w300,
                                AppColors.secondwidgetborder)),
                        const SizedBox(height: 2),
                        Text(
                          'Pool House',
                          style: textStyle(
                            18,
                            FontWeight.w600,
                            Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primarycolor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Icon(
                    LucideIcons.funnel,
                    color: Colors.white,
                    size: 20,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.search,
                    color: AppColors.secondwidgetborder,
                    size: 20,
                  ),
                  const SizedBox(width: 8),

                  /// INPUT
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari pool house...',
                        hintStyle: textStyle(
                          14,
                          FontWeight.w500,
                          AppColors.secondwidgetborder,
                        ),
                        border: InputBorder.none,
                      ),
                      style: textStyle(
                        14,
                        FontWeight.w500,
                        AppColors.secondwidgetborder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildType('Semua'),
                  _buildType('Rumah'),
                  _buildType('Apartemen'),
                  _buildType('Villa'),
                  _buildType('Townhouse'),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildType(String label) {
    final isSelected = selectedType == label;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          setState(() {
            selectedType = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarycolor : Colors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? AppColors.primarycolor : Colors.black12,
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: textStyle(
              9,
              FontWeight.w500,
              isSelected ? Colors.white : AppColors.secondwidgetborder,
            ),
          ),
        ),
      ),
    );
  }
}
