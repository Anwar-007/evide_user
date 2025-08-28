
import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Cores/icon_color.dart';
import 'package:flutter/material.dart';

class TimelineStop extends StatelessWidget {
  final String stopTime; 
  final String stopName;
  final String? time;
  final bool isCurrentStop;
  final bool isLastStop;
  final String? arrivalStatus;
  final bool isVisited;

  const TimelineStop({
    super.key,
    required this.stopTime,
    required this.stopName,
    required this.time,
    required this.isCurrentStop,
    required this.isLastStop,
    this.arrivalStatus,
    required this.isVisited,
  });

  @override
  Widget build(BuildContext context) {

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
              AnimatedContainer(
            curve: Curves.ease,
            duration: Duration(milliseconds: 500),
            transform: Matrix4.translationValues(0, 0* 100, 0),
            child: CircleAvatar(
        radius: 14,
        backgroundColor: isCurrentStop
            ? const Color.fromARGB(255, 194, 179, 251)
            : isVisited
                ? const Color.fromARGB(255, 146, 69, 255)
                : Colors.grey,
        child: isCurrentStop ? GradientIcon(size: 14) : null,
            ),
          ),
        
                if (!isLastStop)
                  Container(
                    height: 90,
                    width: 2,
                    color: isCurrentStop
                        ? const Color.fromARGB(255, 107, 70, 252)
                        : isVisited
                            ? const Color.fromARGB(255, 146, 69, 255)
                            : Colors.grey,
                  ),
              ],
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stopName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
                if (isVisited) ...[
                  Text(
                    'Arrived Time: $time',
                    style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Estimated Time: $stopTime',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else if (isCurrentStop) ...[
                  Text(
                    time ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Bus is Reaching the Stop', style: TextStyle(color: textColor,fontWeight: FontWeight.bold)),
                ] else ...[
                  Text(
                    'Estimated Time: $stopTime',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                 
                ],
              ],
            ),
          ],
        ),
      );
  }
}
