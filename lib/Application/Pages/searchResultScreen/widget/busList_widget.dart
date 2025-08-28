import 'package:evide_user/Application/Cores/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:icons_plus/icons_plus.dart';

class ListItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const ListItem({required this.item, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final details = item['tripDetails'];
    final busdetails = item['busDetails'];
    final destination = details?['destination'];
    final from = details?['from'];
    final stops = details?['Routes'];

    return InkWell(
      onTap: onTap,
      child: Card(
          color: const Color.fromARGB(255, 123, 128, 131),
          elevation: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.003,
                vertical: screenHeight * 0.003),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 98, 49, 140),
                  const Color.fromARGB(255, 103, 145, 228),
                ]),
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              height: screenHeight * 0.195,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        busdetails?['busName'].toUpperCase() ?? 'error',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04),
                      ),
                      Spacer(),
                      Container(
                        width: screenWidth * 0.21,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(3)),
                        child: Text(
                          busdetails?['busNumber'] ?? 'error',
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stops?.first['stopname']
                                .split(' ')
                                .first
                                .toUpperCase() ??
                            'error',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.03),
                      ),
                      Gap(screenWidth * 0.01),
                      Icon(
                        LineAwesome.long_arrow_alt_right_solid,
                        color: Colors.blue,
                        size: screenWidth * 0.09,
                      ),
                      Gap(screenWidth * 0.01),
                      Text(
                        stops?.last['stopname']
                                .split(' ')
                                .first
                                .toUpperCase() ??
                            'error',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.03),
                      ),
                      // Spacer(),
                      // Icon(Icons.star_border),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              from?['stopname'].toUpperCase() ?? 'error',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03),
                            ),
                            Text(
                              from?['stopTime'] ?? 'error',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination?['stopname'].toUpperCase() ?? 'error',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03),
                            ),
                            Text(
                              destination?['stopTime'] ?? 'error',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ]),
                     
                ],
              ),
            ),
          )),
    );
  }
}
