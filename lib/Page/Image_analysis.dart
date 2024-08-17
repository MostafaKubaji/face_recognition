import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tflite/tflite.dart';
import 'package:login/Screens/ShowResults.dart';

class ImageAnalysis extends StatefulWidget {
  final File image;

  const ImageAnalysis({super.key, required this.image});

  @override
  State<ImageAnalysis> createState() => _ImageAnalysisState();
}

class _ImageAnalysisState extends State<ImageAnalysis> {
  String? _result;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? res = await Tflite.loadModel(
        model: "assets/mobilefacenet.tflite",
        labels: "assets/kv.txt",  // تأكد من وجود هذا الملف
      );
      print("Model loaded: $res");
    } catch (e) {
      print("Error loading model: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> analyzeImage() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var output = await Tflite.runModelOnImage(
        path: widget.image.path,
        numResults: 2,
        threshold: 0.5,
      );
      setState(() {
        _result = output?.toString() ?? 'No result';
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowResults(result: _result!),
        ),
      );
    } catch (e) {
      print("Error analyzing image: $e");
      setState(() {
        _result = 'Error analyzing image';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Analysis'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.image.existsSync()) ...[
                Image.file(widget.image),
                SizedBox(height: 20),
              ] else ...[
                Text('No image selected.'),
                SizedBox(height: 20),
              ],
              if (_isLoading) 
                CircularProgressIndicator()
              else ...[
                ElevatedButton(
                  onPressed: analyzeImage,
                  child: Text('Analyze Image'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
