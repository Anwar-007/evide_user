import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Pages/SplashScreen/bloc/splash_bloc.dart';
import 'package:evide_user/Application/Pages/SplashScreen/bloc/splash_event.dart';
import 'package:evide_user/Application/Pages/SplashScreen/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SplashBloc()..add(FetchSponsorImages()),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SponsorImagesLoaded) {
            return _SplashContent(sponsorImageUrls: state.sponsorImageUrls);
          } else if (state is SplashError) {
             Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
            return Scaffold(
              backgroundColor: backGroundColor,
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/images/logo.png',
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.1,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  final List<String> sponsorImageUrls;

  const _SplashContent({required this.sponsorImageUrls});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });

    return Scaffold(
      backgroundColor: backGroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/images/logo.png',
                 width: screenWidth * 0.35,
                  height: screenHeight * 0.1,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.08,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sponsorImageUrls.map((url) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                      child: Image.network(
                        url,
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.5,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  }).toList(),
                ),
              
          ),
        ],
      ),
    );
  }
}
