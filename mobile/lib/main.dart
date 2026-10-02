import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';

void main() {
  runApp(const PlateDetectionApp());
}

class PlateDetectionApp extends StatelessWidget {
  const PlateDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detector de placas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int detections = 0;
  double bestConfidence = 0.0;
  String status = 'Cargando modelo...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detección de placas'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: YOLOView(
              modelPath: 'assets/models/placas.tflite',
              task: YOLOTask.detect,
              confidenceThreshold: 0.35,
              iouThreshold: 0.50,
              cameraResolution: '720p',
              onModelLoad: (_, __) {
                if (!mounted) return;
                setState(() {
                  status = 'Modelo listo';
                });
              },
              onModelError: (error, _, __) {
                if (!mounted) return;
                setState(() {
                  status = 'Error: $error';
                });
              },
              onResult: (results) {
                if (!mounted) return;

                double maxConfidence = 0.0;
                for (final result in results) {
                  if (result.confidence > maxConfidence) {
                    maxConfidence = result.confidence;
                  }
                }

                setState(() {
                  detections = results.length;
                  bestConfidence = maxConfidence;
                });
              },
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: Card(
              color: Colors.black.withValues(alpha: 0.70),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(status),
                      const SizedBox(height: 4),
                      Text('Placas detectadas: $detections'),
                      Text(
                        'Mayor confianza: '
                        '${(bestConfidence * 100).toStringAsFixed(1)}%',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
