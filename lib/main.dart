import 'package:evide_user/Application/Pages/HomeScreen/Home_page.dart';
import 'package:evide_user/Application/Pages/SplashScreen/Splash_screen.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/Search_route_resultScreen.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/widget/TimelineWidget/busTimelineWidget.dart';
import 'package:evide_user/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // webProvider: ReCaptchaV3Provider('your_recaptcha_v3_site_key'),
    androidProvider: AndroidProvider.playIntegrity, // Or use Play Integrity provider
    // appleProvider: AppleProvider.appAttest, // Or use Device Check provider
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePageWrapper(),
          '/searchresult': (context) => SearchresultWrapper(),
          '/showtimeline': (context) => TimelineWrapper(),
        });
  }
}
