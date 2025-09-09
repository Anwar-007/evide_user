import 'package:evide_user/core/utils/app_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 1800),
          curve: Curves.easeIn,
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: child,
            );
          },
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: ClipRRect(
              child: Image.asset(
                AppAssets.pngApplogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
