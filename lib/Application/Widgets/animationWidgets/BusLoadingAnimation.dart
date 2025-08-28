import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BusLoadingAnimationWidget extends StatelessWidget {
  const BusLoadingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Center(
        child: Lottie.asset(
          'asset/Artboard.json', // Replace with your Lottie animation JSON file path
          width: screenWidth * 0.3, // Adjust size of the animation
          height: screenHeight * 0.2,
          repeat: true, // Ensure the animation loops
        ),
      ),
    );
  }
}
