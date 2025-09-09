import 'package:evide_user/core/utils/app_imports.dart';
import 'package:evide_user/features/splash_screen/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppGlobalKeys.navigatorKey,
          title: 'Evide AI',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: SplashScreen(),
        );
      },
    );
  }
}
