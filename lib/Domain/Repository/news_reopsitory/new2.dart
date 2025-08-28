// import 'package:flutter/material.dart';
// import 'package:flutter_application_evdeai/Applications/core/colors.dart';
// import 'package:flutter_application_evdeai/Applications/pages/busoperatorDashscreen/BusOpDash_bloc/bus_opdash_bloc.dart';
// import 'package:flutter_application_evdeai/Applications/widgets/custom_button.dart';
// import 'package:flutter_application_evdeai/domain/Repository/buslivelocation_repository/sharelivelocation_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// class BusStandWrapper extends StatelessWidget {
//   const BusStandWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize background task dispatcher for Workmanager
//     Workmanager().initialize(callbackDispatcher);

//     // Ensure BlocProvider is above the widget tree
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     final busNumber = args?['busNumber'] ?? 'DefaultBusName';

//     // Wrap the widget tree with BlocProvider to make sure BusOpdashBloc is available
//     return BlocProvider(
//       create: (context) => BusOpdashBloc(busNumber),
//       child: const BusStandPage(),
//     );
//   }
// }

// /// Callback dispatcher for background tasks
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       final busNumber = inputData?['busNumber'];
//       if (busNumber != null) {
//         final repo = SharelivelocationRepo(busNumber);
//         final position = await repo.getCurrentLocation();

//         // Save the location to Firestore
//         await repo.saveLocationToFirestore(
//             position.latitude, position.longitude);
//       }
//     } catch (e) {
//       print("Error in background task: $e");
//     }
//     return Future.value(true);
//   });
// }

// class BusStandPage extends StatefulWidget {
//   const BusStandPage({super.key});

//   @override
//   State<BusStandPage> createState() => _BusStandPageState();
// }

// class _BusStandPageState extends State<BusStandPage> {
//   Map<String, dynamic>? _busData;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       setState(() {
//         _busData = args;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(_busData?['busName'] ?? "Bus Stand"),
//       ),
//       body: SingleChildScrollView(
//         // Ensure the body is scrollable
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: BlocBuilder<BusOpdashBloc, BusOpdashState>(
//             builder: (context, state) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/images/busfull.png'),
//                   const SizedBox(height: 70),
//                   CustomButton(
//                     onTap: () {
//                       final bloc = context.read<BusOpdashBloc>();
//                       if (state is TripStartedState) {
//                         bloc.add(StopTripEvent());
//                         SharelivelocationRepo.cancelBackgroundTask();
//                         FlutterForegroundTask.stopService();
//                       } else {
//                         bloc.add(StartTripEvent());
//                         SharelivelocationRepo.scheduleBackgroundTask(
//                           _busData?['busNumber'] ?? 'DefaultBusName',
//                         );
//                         FlutterForegroundTask.startService(
//                           notificationTitle: 'Bus Location Service',
//                           notificationText: 'Sharing live location updates',
//                         );
//                       }
//                     },
//                     text: (state is TripStartedState)
//                         ? 'Stop Your Trip'
//                         : 'Start Your Trip',
//                     boxDecoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.blue, Colors.purple, Colors.cyan],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     height: 60,
//                     width: double.infinity,
//                     textStyle: TextStyle(
//                       color: backGroundColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                   const Gap(10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CustomButton(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/bustimepage');
//                         },
//                         text: 'Time Schedule',
//                         boxDecoration: BoxDecoration(
//                           color: textColor,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         height: 60,
//                         width: 150,
//                         textStyle: TextStyle(
//                           color: backGroundColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const Spacer(),
//                       CustomButton(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/busroutepage');
//                         },
//                         text: 'Your Route',
//                         boxDecoration: BoxDecoration(
//                           color: textColor,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         height: 60,
//                         width: 150,
//                         textStyle: TextStyle(
//                           color: backGroundColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 40),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/sharebuspage',
//                           arguments: _busData);
//                     },
//                     child: const Text(
//                       'Share Your Bus',
//                       style: TextStyle(color: Colors.red, fontSize: 18),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }