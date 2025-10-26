import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dermacek/service/analyze_service.dart';

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key});

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  // Service untuk AI
  late AnalyzeService _analyzeService;
  
  File? _image;
  Map<String, double>? _results;
  bool _isAnalyzing = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _analyzeService = AnalyzeService();
    _loadModel();
  }

  // Load model saat app start
  Future<void> _loadModel() async {
    try {
      await _analyzeService.loadModel();
      setState(() {});
      
      if (mounted) {
        _showSnackBar(
          '✅ Model AI berhasil dimuat',
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(
          'Gagal memuat model: $e',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  // Ambil gambar dari kamera
  Future<void> _pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _results = null;
        });
      }
    } catch (e) {
      _showSnackBar('Gagal mengambil gambar dari kamera: $e');
    }
  }

  // Ambil gambar dari galeri
  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _results = null;
        });
      }
    } catch (e) {
      _showSnackBar('Gagal mengambil gambar dari galeri: $e');
    }
  }

  // Analisis gambar dengan AI
  Future<void> _analyzeImage() async {
    if (_image == null) {
      _showSnackBar('Pilih gambar terlebih dahulu.');
      return;
    }

    if (!_analyzeService.isModelLoaded) {
      _showSnackBar('Model AI belum siap.');
      return;
    }

    setState(() => _isAnalyzing = true);

    try {
      // Jalankan AI inference
      final results = await _analyzeService.analyzeImage(_image!);
      
      setState(() {
        _results = results;
        _isAnalyzing = false;
      });

      // Simpan ke history
      await _analyzeService.saveToHistory(results);

      _showSnackBar('✅ Analisis selesai!', backgroundColor: Colors.green);
    } catch (e) {
      setState(() => _isAnalyzing = false);
      _showSnackBar('Gagal menganalisis gambar: $e');
    }
  }

  void _showSnackBar(String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _clearImage() {
    setState(() {
      _image = null;
      _results = null;
    });
  }

  @override
  void dispose() {
    _analyzeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Kulit'),
        actions: [
          // Status badge AI
          if (_analyzeService.isModelLoaded)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle, 
                        size: 14, 
                        color: theme.colorScheme.onTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'AI Ready',
                        style: TextStyle(
                          fontSize: 11, 
                          color: theme.colorScheme.onTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Loading card jika model belum ready
            if (!_analyzeService.isModelLoaded)
              Card(
                color: theme.colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Memuat model AI...',
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            if (!_analyzeService.isModelLoaded)
              const SizedBox(height: 16),

            // Preview gambar
            Card(
              clipBehavior: Clip.antiAlias,
              child: _image != null
                  ? Stack(
                      children: [
                        Image.file(
                          _image!,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton.filled(
                            onPressed: _clearImage,
                            icon: const Icon(Icons.close),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 300,
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Pilih foto area kulit',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pastikan foto jelas dan fokus',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            
            const SizedBox(height: 16),

            // Tombol Camera & Gallery
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _analyzeService.isModelLoaded 
                        ? _pickImageFromCamera 
                        : null,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Kamera'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: _analyzeService.isModelLoaded 
                        ? _pickImageFromGallery 
                        : null,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                  ),
                ),
              ],
            ),
            
            // Tombol Analisis
            if (_image != null) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: (_analyzeService.isModelLoaded && !_isAnalyzing)
                    ? _analyzeImage
                    : null,
                icon: _isAnalyzing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.analytics),
                label: Text(_isAnalyzing ? 'Menganalisis...' : 'Analisis Sekarang'),
              ),
            ],
            
            // Hasil Analisis
            if (_results != null) ...[
              const SizedBox(height: 24),
              _buildResultCard(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(ThemeData theme) {
    final sortedResults = _results!.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topResult = sortedResults.first;
    final confidence = topResult.value;
    final recommendation = RecommendationService.getRecommendation(
      topResult.key,
      confidence,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hasil Analisis AI',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

            // Result chart
            ...sortedResults.asMap().entries.map((entry) {
              final index = entry.key;
              final result = entry.value;
              final percentage = (result.value * 100).toStringAsFixed(1);
              final isTop = index == 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            result.key,
                            style: TextStyle(
                              fontWeight: isTop ? FontWeight.bold : FontWeight.w500,
                              fontSize: isTop ? 16 : 14,
                              color: isTop ? theme.colorScheme.primary : null,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isTop 
                                ? theme.colorScheme.primaryContainer
                                : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$percentage%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isTop 
                                  ? theme.colorScheme.onPrimaryContainer 
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: result.value,
                      minHeight: isTop ? 10 : 8,
                      borderRadius: BorderRadius.circular(4),
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            Divider(color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 16),

            // Rekomendasi
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getRecommendationColor(topResult.key, confidence, theme)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getRecommendationColor(topResult.key, confidence, theme)
                      .withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _getRecommendationIcon(topResult.key, confidence),
                    color: _getRecommendationColor(topResult.key, confidence, theme),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rekomendasi',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getRecommendationColor(topResult.key, confidence, theme),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recommendation,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: _getRecommendationColor(topResult.key, confidence, theme)
                                .withValues(alpha: 0.9),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRecommendationColor(String diseaseName, double confidence, ThemeData theme) {
    if (diseaseName.toLowerCase().contains('normal') ||
        diseaseName.toLowerCase().contains('sehat')) {
      return theme.colorScheme.tertiary;
    } else if (confidence < 0.6) {
      return const Color(0xFFFF9800); // Orange
    } else {
      return theme.colorScheme.error;
    }
  }

  IconData _getRecommendationIcon(String diseaseName, double confidence) {
    if (diseaseName.toLowerCase().contains('normal') ||
        diseaseName.toLowerCase().contains('sehat')) {
      return Icons.check_circle;
    } else if (confidence < 0.6) {
      return Icons.help_outline;
    } else {
      return Icons.medical_information;
    }
  }
}