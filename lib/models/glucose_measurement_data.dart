class GlucoseMeasurementData {
  final String title;
  final String subtitle;
  final String currentGlucoseValue;
  final String currentGlucoseUnit;
  final String hypoLevelText;
  final String lastScanText;
  final String lastScanValue;
  final String growthStatus;
  final String mealStatus;
  final String insulinUnits;

  GlucoseMeasurementData({
    required this.title,
    required this.subtitle,
    required this.currentGlucoseValue,
    required this.currentGlucoseUnit,
    required this.hypoLevelText,
    required this.lastScanText,
    required this.lastScanValue,
    required this.growthStatus,
    required this.mealStatus,
    required this.insulinUnits,
  });
}
