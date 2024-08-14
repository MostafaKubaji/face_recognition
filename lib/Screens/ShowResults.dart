import 'package:flutter/material.dart';

class ShowResults extends StatelessWidget {
  final String result;

  const ShowResults({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Results'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Analysis Results:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              Text(
                result,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
