

// import 'package:animated_icon/animated_icon.dart';
// import 'package:evde_ai/Application/Cores/colors.dart';
// import 'package:evde_ai/Application/Pages/HomeScreen/Home_page.dart';
// import 'package:evde_ai/Application/Pages/busoperatorDashscreen/BusOperatorDashScreen.dart';
// import 'package:evde_ai/Application/Pages/myaccountpage/my_account_page.dart';
// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';

// class MainPageScreen extends StatefulWidget {
//   const MainPageScreen({super.key});

//   @override
//   State<MainPageScreen> createState() => _MainPageScreenState();
// }

// class _MainPageScreenState extends State<MainPageScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const HomePageWrapper(),
//     // BusStandPage(),
//     MyAccountPage()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: backGroundColor,
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//           unselectedItemColor: Colors.purple[200],
//           unselectedIconTheme: IconThemeData(color: Colors.purple[200]),
//           showUnselectedLabels: true,
//           fixedColor: Colors.blue[200],
//           currentIndex: _currentIndex,
//           backgroundColor: backGroundColor,
//           type: BottomNavigationBarType.shifting,
//           iconSize: 18,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           items: [
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   IonIcons.home,
//                 ),
//                 label: 'Home',
//                 activeIcon: AnimateIcon(onTap: (){}, iconType: IconType.animatedOnTap, animateIcon: AnimateIcons.home,
//                 color: Colors.blue, height: 20, width: 20),
//                 backgroundColor: backGroundColor),
//             // BottomNavigationBarItem(
//             //     icon: Icon(
//             //       Clarity.map_marker_solid,
//             //     ),
//             //     activeIcon: AnimateIcon(
//             //       onTap: () {},
//             //       iconType: IconType.animatedOnTap,
//             //       animateIcon: AnimateIcons.mapPointer,
//             //       color: Colors.blue,
//             //       height: 20,
//             //       width: 20,
//             //     ),
//             //     label: 'Find the Stops',
//             //     backgroundColor: backGroundColor),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   EvaIcons.person,
//                 ),
//                 label: 'My Account',
//                 activeIcon: AnimateIcon(
//                   key: UniqueKey(),
//                   onTap: () {},
//                   iconType: IconType.animatedOnTap,
//                   height: 20,
//                   width: 20,
//                   color: Colors.blue,
//                   animateIcon: AnimateIcons.activity,
//                 ),
//                 backgroundColor: backGroundColor),
//           ]),
//     );
//   }
// }
