import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceRecognitionService {
  late FaceDetector _faceDetector;
  Interpreter? _interpreter;

  FaceRecognitionService() {
    final options = FaceDetectorOptions(
      enableContours: false,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.fast,
      enableClassification: true,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/mobilefacenet.tflite');
      debugPrint("TFLite Model loaded successfully");
    } catch (e) {
      debugPrint("Error loading TFLite model: $e");
    }
  }

  Future<List<Face>> detectFaces(InputImage inputImage) async {
    return await _faceDetector.processImage(inputImage);
  }

  // Calculate Euclidean Distance between two feature embedding vectors
  double calculateDistance(List<double> e1, List<double> e2) {
    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  // Check if detected face matches stored profile
  bool isFaceMatched(List<double> registeredFace, List<double> liveFace, {double threshold = 0.85}) {
    return calculateDistance(registeredFace, liveFace) < threshold;
  }

  void dispose() {
    _faceDetector.close();
    _interpreter?.close();
  }
}
