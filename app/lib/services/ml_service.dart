import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';
import '../models/eye_tracking_data.dart';
import 'dart:math';

class MLService {
  final FaceDetector _faceDetector = GoogleMLKit.vision.faceDetector(
    FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
      enableTracking: true,
      minFaceSize: 0.15,
    ),
  );
  
  CameraController? _cameraController;
  
  Future<void> initialize() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    
    _cameraController = CameraController(
      front,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    
    await _cameraController!.initialize();
  }
  
  Future<EyeTrackingData?> processImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    
    final bytes = allBytes.done().buffer.asUint8List();
    
    final InputImage inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.bgra8888,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
    
    final List<Face> faces = await _faceDetector.processImage(inputImage);
    
    if (faces.isEmpty) return null;
    
    final face = faces.first;
    final leftEye = face.landmarks[FaceLandmarkType.leftEye]?.position;
    final rightEye = face.landmarks[FaceLandmarkType.rightEye]?.position;
    
    return EyeTrackingData(
      isBlinking: face.leftEyeOpenProbability! < 0.1 || 
                  face.rightEyeOpenProbability! < 0.1,
      leftEyePosition: leftEye != null ? Point(leftEye.x, leftEye.y) : Point(0, 0),
      rightEyePosition: rightEye != null ? Point(rightEye.x, rightEye.y) : Point(0, 0),
      eyeOpenProbability: (face.leftEyeOpenProbability! + 
                          face.rightEyeOpenProbability!) / 2,
    );
  }
  
  void dispose() {
    _faceDetector.close();
    _cameraController?.dispose();
  }
} 