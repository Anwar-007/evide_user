// // ignore: file_names
// import 'package:evde_ai/Application/Cores/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class BusQrPage extends StatefulWidget {
  
  
//   const BusQrPage();

//   @override
//   State<BusQrPage> createState() => _BusQrPageState();
// }

// class _BusQrPageState extends State<BusQrPage> {
//  Map<String, dynamic>? busData; 
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       busData = args;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       backgroundColor: backGroundColor,
//       body: Padding(padding: EdgeInsets.all(30),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
// Row(
//   children: [
//     IconButton(onPressed: (){
//       Navigator.pop(context);
//     }, icon: Icon(Icons.arrow_back)),
//     Gap(10),
//     Text('Share Your Bus',style: TextStyle(fontSize: 20,color: textColor,fontWeight: FontWeight.bold),)
//   ],
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.end,
//   children: [
//     IconButton(onPressed: (){
//       Navigator.pushNamed(context, '/scanthebus');
//     }, icon: Icon(BoxIcons.bx_scan,size: 28,)),
//     Gap(20),
//     CircleAvatar(
//       child: IconButton(onPressed: (){}, icon: Icon(IonIcons.share_social,size: 24,)),
//     )
//   ],
// ),
// Gap(40),
// // Center(child: QrCodeWidget()),
//  QrImageView(
//    data: busData != null ? busData.toString() : '', 
//    version: QrVersions.auto,
//    size: 200.0,
//    gapless: false,
//  )
//         ],
//       ),),
//     );
//   }
// }