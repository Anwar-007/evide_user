import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evide_user/Application/Pages/HomeScreen/User_Home_bloc/user_home_bloc.dart';
import 'package:evide_user/Application/Widgets/taxi/votefortaxi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Cores/colors.dart';
import '../../../../Widgets/busStopData.dart';
import '../../../../Widgets/bus_detail_model.dart';

class CardButonWrapper extends StatelessWidget {
  const CardButonWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeBloc(),
      child: CardButtonWidget(),
    );
  }
}

class CardButtonWidget extends StatefulWidget {
  const CardButtonWidget({super.key});

  @override
  State<CardButtonWidget> createState() => _CardButtonWidgetState();
}

class _CardButtonWidgetState extends State<CardButtonWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final homeBloc = context.read<UserHomeBloc>();
    return BlocListener<UserHomeBloc, UserHomeState>(
        listener: (context, state) {
          if (state is UserHomeVoteSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showThankYouDialog(context, state.message);
            });
          } else if (state is UserHomeErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showErrorDialog(context, state.error);
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  final myList = tirTOperntharr.toList();
                  try {
                    await _firestore
                        .collection('SampleBusStops')
                        .doc('Route 3')
                        .set({
                      'Routes': tirTOperth,
                      'Routesname': tirTOperntharr,
                    });
                    print('saved : $tirTOkaiarr');
                  } catch (e) {
                    print('Error saving data: $e');
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  height: screenHeight * 0.13,
                  width: screenWidth * 0.25,
                  child: Column(
                    children: [
                      Card(
                          elevation: 0,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'asset/images/bus1.png',
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.19,
                              fit: BoxFit.fill,
                            ),
                          )),
                      const Text(
                        'BUS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => showVotingDialog(
                    context,
                    'Train',
                    _nameController,
                    _emailController,
                    (context, vote) => homeBloc.add(SaveVoteEvent(
                          collectionName: 'Train',
                          name: _nameController.text,
                          email: _emailController.text,
                          vote: vote,
                        ))),
                child: Container(
                  color: Colors.transparent,
                  height: screenHeight * 0.13,
                  width: screenWidth * 0.25,
                  child: Column(
                    children: [
                      Card(
                          elevation: 0,
                          color: backGroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'asset/images/train2.png',
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.19,
                              fit: BoxFit.fill,
                            ),
                          )),
                      const Text(
                        'TRAIN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => showVotingDialog(
                    context,
                    'Taxi',
                    _nameController,
                    _emailController,
                    (context, vote) => homeBloc.add(SaveVoteEvent(
                          collectionName: 'Taxi',
                          name: _nameController.text,
                          email: _emailController.text,
                          vote: vote,
                        ))),
                child: Container(
                  color: Colors.transparent,
                  height: screenHeight * 0.13,
                  width: screenWidth * 0.27,
                  child: Column(
                    children: [
                      Card(
                          color: backGroundColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'asset/images/car1.png',
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.25,
                              fit: BoxFit.fill,
                            ),
                          )),
                      const Text(
                        'TAXI',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
