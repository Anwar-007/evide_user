import 'package:evide_user/core/utils/app_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppGlobalKeys.navigatorKey,
      title: 'Evide AI',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
