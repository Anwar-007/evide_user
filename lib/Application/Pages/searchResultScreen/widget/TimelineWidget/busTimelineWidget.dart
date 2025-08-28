
import 'package:evide_user/Application/Pages/searchResultScreen/widget/TimelineWidget/Timeline_bloc/timeline_bloc.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/widget/TimelineWidget/busroutewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineWrapper extends StatelessWidget {
  const TimelineWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final busNumber = args?['busDetails']['busNumber'] ?? 'DefaultBusName';
    final startTime = args?['tripDetails']['startTime'];
    final endTime = args?['tripDetails']['endTime'];

    return BlocProvider(
      create: (context) =>
          TimelineBloc()..add(LoadBusData(busNumber, startTime, endTime)),
      child: const TimelineWidget(),
    );
  }
}

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimelineBloc, TimelineState>(
      listener: (context, state) {
        if (state is TimelineError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is TimelineLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is TimelineLoaded) {
          print('arrivedTime: ${state.tripData['arrivedTime']}');
          final tripData = state.tripData;
          final routes = tripData['Routes'] as List<dynamic>? ?? [];
          final arrivedTimeMap =
              tripData['arrivedTime'] as Map<String, dynamic>? ?? {};
          final currentIndex = tripData['currentStopIndex'] as int? ?? -1;

          print('current index: $currentIndex');

          return Scaffold(
            appBar: AppBar(
              title: const Text('Bus Timeline'),
            ),
            body: ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final stop = routes[index];
                final isCurrentStop = index == currentIndex;
                final isPastStop = index < currentIndex;

                // Match arrived time to the stop index
                final arrivedTime = arrivedTimeMap[index.toString()] ?? 'N/A';

                return TimelineStop(
                    stopTime: stop['stopTime'],
                    stopName: stop['stopname'],
                    time: arrivedTime,
                    isCurrentStop: isCurrentStop,
                    isLastStop: index == routes.length - 1,
                    isVisited: isPastStop);
              },
            ),
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
