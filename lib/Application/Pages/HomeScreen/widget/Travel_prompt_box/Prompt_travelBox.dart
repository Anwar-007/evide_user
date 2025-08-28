import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../Cores/colors.dart';


class PromptTravel extends StatelessWidget {
  const PromptTravel({super.key});

  @override

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                 
                  height:screenHeight * 0.12,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft),
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      
                     decoration: BoxDecoration(
                      color: backGroundColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)
                     ),
                     child:  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 27,
                            height: 27,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.purple],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomLeft),
                                    shape: BoxShape.circle),
                                  
                            child: Center(
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(shape: BoxShape.circle,color: backGroundColor),
                                child: const Center(
                                  child:  Icon(MingCute.lock_line,color: Colors.deepPurple,size: 20,),
                                )
                              ),
                            ),
                          ),
                      ),
                     ),
                    ),
                  ),
                ),
              );
  }
}