import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Model untuk menyimpan hasil analisis
class AnalysisRecord {
  final String topResult;
  final double confidence;
  final Map<String, double> allResults;
  final DateTime timestamp;

  AnalysisRecord({
    required this.topResult,
    required this.confidence,
    required this.allResults,
    required this.timestamp,
  });

  factory AnalysisRecord.fromJson(Map<String, dynamic> json) {
    return AnalysisRecord(
      topResult: json['topResult'] as String,
      confidence: json['confidence'] as double,
      allResults: Map<String, double>.from(json['allResults'] as Map),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topResult': topResult,
      'confidence': confidence,
      'allResults': allResults,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Service untuk AI Model dan Image Processing
class AnalyzeService {
  static final AnalyzeService _instance = AnalyzeService._internal();

  factory AnalyzeService() {
    return _instance;
  }

  AnalyzeService._internal();

  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isModelLoaded = false;

  bool get isModelLoaded => _isModelLoaded;
  List<String> get labels => _labels;

  /// Load TFLite model dari assets
  Future<void> loadModel() async {
    try {
      debugPrint('🔄 Loading model from: assets/model/skin_disease_model.tflite');
      
      // Load interpreter
      _interpreter = await Interpreter.fromAsset('assets/model/skin_disease_model.tflite');
      debugPrint('✅ Interpreter loaded');

      // Load labels dari file
      debugPrint('🔄 Loading labels from: assets/model/labels.txt');
      final labelsData = await rootBundle.loadString('assets/model/labels.txt');
      _labels = labelsData.split('\n').where((l) => l.isNotEmpty).toList();
      debugPrint('✅ Labels loaded: $_labels');

      _isModelLoaded = true;
      debugPrint('✅ Model loaded successfully');
      debugPrint('📋 Labels: $_labels');
      
      // Print model info
      final inputDetails = _interpreter!.getInputTensors();
      final outputDetails = _interpreter!.getOutputTensors();
      debugPrint('📊 Input tensors: ${inputDetails.length}');
      debugPrint('📊 Output tensors: ${outputDetails.length}');
      if (inputDetails.isNotEmpty) {
        debugPrint('📊 Input shape: ${inputDetails[0].shape}');
      }
      if (outputDetails.isNotEmpty) {
        debugPrint('📊 Output shape: ${outputDetails[0].shape}');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error loading model: $e');
      debugPrint('❌ Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Analisis gambar dengan TFLite model
  Future<Map<String, double>> analyzeImage(File imageFile) async {
    if (!_isModelLoaded || _interpreter == null) {
      throw Exception('Model belum dimuat');
    }

    try {
      // Load dan decode image
      final imageBytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) {
        throw Exception('Gagal decode gambar');
      }

      // Resize ke 224x224 (sesuai input model)
      img.Image resizedImage = img.copyResize(
        image,
        width: 224,
        height: 224,
        interpolation: img.Interpolation.linear,
      );

      // Convert ke Float32List [1, 224, 224, 3] dengan normalisasi
      var input = List.generate(
        1,
        (batch) => List.generate(
          224,
          (y) => List.generate(
            224,
            (x) {
              final pixel = resizedImage.getPixel(x, y);
              return [
                pixel.r / 255.0,
                pixel.g / 255.0,
                pixel.b / 255.0,
              ];
            },
          ),
        ),
      );

      // Output buffer [1, num_classes]
      var output = List.filled(
        1,
        List<double>.filled(_labels.length, 0.0),
      ).map((e) => List<double>.filled(_labels.length, 0.0)).toList();

      // Run inference
      _interpreter!.run(input, output);

      // Parse hasil prediksi
      Map<String, double> results = {};
      for (int i = 0; i < _labels.length; i++) {
        results[_labels[i]] = output[0][i];
      }

      debugPrint('✅ Analysis complete: $results');
      return results;
    } catch (e) {
      debugPrint('❌ Analysis error: $e');
      rethrow;
    }
  }

  /// Simpan hasil analisis ke history
  Future<void> saveToHistory(Map<String, double> results) async {
    try {
      final topResult =
          results.entries.reduce((a, b) => a.value > b.value ? a : b);
      final timestamp = DateTime.now();

      final record = AnalysisRecord(
        topResult: topResult.key,
        confidence: topResult.value,
        allResults: results,
        timestamp: timestamp,
      );

      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList('analysis_history') ?? [];
      historyJson.add(jsonEncode(record.toJson()));
      await prefs.setStringList('analysis_history', historyJson);

      debugPrint('💾 Saved to history:');
      debugPrint('   Time: $timestamp');
      debugPrint(
          '   Result: ${topResult.key} (${(topResult.value * 100).toStringAsFixed(1)}%)');
    } catch (e) {
      debugPrint('❌ Error saving to history: $e');
      rethrow;
    }
  }

  /// Dispose resources
  void dispose() {
    _interpreter?.close();
    _isModelLoaded = false;
  }
}

/// Service untuk mendapatkan rekomendasi dari hasil analisis
class RecommendationService {
  static String getRecommendation(
    String diseaseName,
    double confidence,
  ) {
    if (diseaseName.toLowerCase().contains('normal') ||
        diseaseName.toLowerCase().contains('sehat')) {
      return 'Kulit Anda terlihat sehat. Jaga kebersihan dan hindari paparan berlebihan.';
    } else if (confidence < 0.6) {
      return 'Hasil analisis kurang pasti (${(confidence * 100).toStringAsFixed(1)}%). '
          'Coba ambil foto dengan pencahayaan lebih baik atau konsultasi ke dokter.';
    } else {
      return 'Terdetaksi kemungkinan $diseaseName dengan tingkat kepercayaan ${(confidence * 100).toStringAsFixed(1)}%. '
          'Kami sarankan untuk segera konsultasi dengan dokter atau kunjungi faskes terdekat untuk pemeriksaan lebih lanjut.';
    }
  }

  static String getRecommendationTitle(String diseaseName) {
    if (diseaseName.toLowerCase().contains('normal') ||
        diseaseName.toLowerCase().contains('sehat')) {
      return 'Kulit Sehat';
    } else if (diseaseName.toLowerCase().contains('eksim')) {
      return 'Kemungkinan Eksim';
    } else if (diseaseName.toLowerCase().contains('kadas') ||
        diseaseName.toLowerCase().contains('panu')) {
      return 'Kemungkinan Infeksi Jamur';
    }
    return 'Hasil Analisis';
  }
}