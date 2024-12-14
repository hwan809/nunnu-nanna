import 'package:flutter/foundation.dart';
import '../services/ml_service.dart';
import '../models/eye_tracking_data.dart';

class EyeTrackingProvider with ChangeNotifier {
  final MLService _mlService = MLService();
  EyeTrackingData? _lastTracking;
  bool _isProcessing = false;
  
  EyeTrackingData? get lastTracking => _lastTracking;
  
  Future<void> startTracking() async {
    await _mlService.initialize();
    _isProcessing = true;
    
    _mlService._cameraController?.startImageStream((image) async {
      if (!_isProcessing) return;
      
      _isProcessing = false;
      final tracking = await _mlService.processImage(image);
      if (tracking != null) {
        _lastTracking = tracking;
        notifyListeners();
      }
      _isProcessing = true;
    });
  }
  
  void stopTracking() {
    _isProcessing = false;
    _mlService.dispose();
  }
} 