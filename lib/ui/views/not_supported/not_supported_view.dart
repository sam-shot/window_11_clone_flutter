import 'package:flutter/material.dart';

class NotSupported extends StatelessWidget {
  const NotSupported({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "App Not Supported on Mobile phones", 
            ),
          ],
        ),
      ),
    );
  }
}
