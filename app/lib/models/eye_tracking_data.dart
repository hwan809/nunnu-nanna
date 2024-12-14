import 'dart:math';

class EyeTrackingData {
  final bool isBlinking;
  final Point<double> leftEyePosition;
  final Point<double> rightEyePosition;
  final double eyeOpenProbability;
  
  EyeTrackingData({
    required this.isBlinking,
    required this.leftEyePosition,
    required this.rightEyePosition,
    required this.eyeOpenProbability,
  });
} 