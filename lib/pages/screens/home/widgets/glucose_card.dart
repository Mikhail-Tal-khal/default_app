import 'package:default_app/pages/screens/home/widgets/glucose_action_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/glucose_measurement_data.dart';

class GlucoseCardSection extends StatelessWidget {
  const GlucoseCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final data = GlucoseMeasurementData(
      title: 'Glucose',
      subtitle: 'Latest measurement',
      currentGlucoseValue: '4,5',
      currentGlucoseUnit: 'mmol/L',
      hypoLevelText: 'Hypos level',
      lastScanText: 'Last Scan',
      lastScanValue: '5,2 mmol/L',
      growthStatus: 'Negative Growth',
      mealStatus: 'Before meal',
      insulinUnits: '12 Insulin units',
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final double cardPadding = isSmallScreen ? 12.0 : 16.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF5B86E5), const Color(0xFF36D1C4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1,
            ),
          ),
          child: GlucoseCardContent(data: data, isSmallScreen: isSmallScreen),
        );
      },
    );
  }
}

class GlucoseCardContent extends StatelessWidget {
  final GlucoseMeasurementData data;
  final bool isSmallScreen;

  const GlucoseCardContent({super.key, required this.data, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and date row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isSmallScreen ? 13 : 14,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.white, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('MMM dd, yyyy').format(DateTime.now()),
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Glucose value row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      data.currentGlucoseValue,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 36 : 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data.currentGlucoseUnit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      data.hypoLevelText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.info_outline, color: Colors.white70, size: 16),
                  ],
                ),
              ],
            ),

            // Last scan column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.lastScanText,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  data.lastScanValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.trending_down, color: Colors.red[300], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      data.growthStatus,
                      style: TextStyle(color: Colors.red[300], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: GlucoseActionButton(
                text: data.mealStatus,
                icon: Icons.restaurant,
                isSmallScreen: isSmallScreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlucoseActionButton(
                text: data.insulinUnits,
                icon: Icons.medical_services,
                isSmallScreen: isSmallScreen,
              ),
            ),
            const SizedBox(width: 12),
            AddButton(
              onPressed: () => _showSnackbar(context, 'Add measurement'),
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
      ],
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}