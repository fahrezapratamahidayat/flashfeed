import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const IntroPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(height: 40),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
