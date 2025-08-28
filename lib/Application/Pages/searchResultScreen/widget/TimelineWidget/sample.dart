import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RouteScreen extends StatefulWidget {
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Route"),
        backgroundColor: Colors.white,
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('routes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No route data available."));
          }

          List<Map<String, dynamic>> routes = snapshot.data!.docs.map((doc) {
            return {
              "stopName": doc['stopName'],
              "time": doc['time'],
              "status": doc['status'],
            };
          }).toList();

          return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(height: 40),
                    Expanded(
                      child: Stack(
                        children: [
                          // Timeline
                          Positioned.fill(
                            child: CustomPaint(
                              painter: RoutePainter(_animation.value),
                            ),
                          ),
                          Positioned.fill(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children:
                                        routes.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      var stop = entry.value;
                                      return RouteStop(
                                        stop['stopName'] ?? 'Unknown',
                                        stop['time'] ?? '--:--',
                                        stop['status'] ?? 'Unknown',
                                        index / (routes.length - 1),
                                        _animation.value,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                          Positioned(
                            left: 89,
                            top: (10 + _animation.value * 434),
                            child: Icon(
                              Icons.directions_bus,
                              color: Colors.purple,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
        }
      ));
  }
}

class RouteStop extends StatelessWidget {
  final String location;
  final String time;
  final String status;
  final double stopProgress;
  final double currentProgress;

  RouteStop(this.location, this.time, this.status, this.stopProgress, this.currentProgress);

  @override
  Widget build(BuildContext context) {
    Color circleColor =
    currentProgress >= stopProgress ? Colors.purple : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(width: 40),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: circleColor, size: 12),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                location,
                style: TextStyle(color: Colors.black),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 40),
              child: Text(
                status,
                style: TextStyle(
                  color: status.contains("delay") ? Colors.red : Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 70), // Matches the timeline spacing
      ],
    );
  }
}

class RoutePainter extends CustomPainter {
  final double progress;

  RoutePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint solidLinePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2;

    Paint dotPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double startY = 10;
    double stopHeight = size.height / 6.9;
    double totalHeight = 5 * stopHeight;


    double currentY = startY + progress * totalHeight;


    for (int i = 0; i < 5; i++) {
      double y1 = startY + i * stopHeight;
      double y2 = y1 + stopHeight;

      if (currentY >= y2) {

        canvas.drawLine(Offset(104, y1), Offset(104, y2), solidLinePaint);
      } else if (currentY > y1 && currentY < y2) {
        double filledLength = currentY - y1;
        canvas.drawLine(Offset(104, y1), Offset(104, y1 + filledLength), solidLinePaint);

        Path path = Path();
        path.moveTo(104, y1 + filledLength);
        path.lineTo(104, y2);

        double dashLength = 5;
        double dashSpace = 5;
        Path dashPath = Path();

        for (PathMetric pathMetric in path.computeMetrics()) {
          double distance = 0;
          while (distance < pathMetric.length) {
            dashPath.addPath(
                pathMetric.extractPath(distance, distance + dashLength),
                Offset.zero);
            distance += dashLength + dashSpace;
          }
        }
        canvas.drawPath(dashPath, dotPaint);
      } else {
        Path path = Path();
        path.moveTo(104, y1);
        path.lineTo(104, y2);

        double dashLength = 5;
        double dashSpace = 5;
        Path dashPath = Path();

        for (PathMetric pathMetric in path.computeMetrics()) {
          double distance = 0;
          while (distance < pathMetric.length) {
            dashPath.addPath(
                pathMetric.extractPath(distance, distance + dashLength),
                Offset.zero);
            distance += dashLength + dashSpace;
          }
        }
        canvas.drawPath(dashPath, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}