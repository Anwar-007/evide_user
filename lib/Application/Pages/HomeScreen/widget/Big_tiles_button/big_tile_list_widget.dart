import 'package:flutter/material.dart';

import '../../../../Cores/colors.dart';


class BigTileListWidget extends StatelessWidget {
  const BigTileListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(  
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     SizedBox(
                      height: 230,
                      width: 170,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('asset/images/train2.png',
                            height: 160,
                            width: 170,
                            fit: BoxFit.fill,
                            ),
                  
                          ),
                          const Row(
                            children: [
                              Text('Book your train ',style: TextStyle(color: textColor,fontSize: 16,fontWeight: FontWeight.bold),),
                              Icon(Icons.arrow_forward_rounded)
                            ],
                          ),
                          const Text("Let's go for a trip",style:  TextStyle(color: textColor,fontSize: 14,),)
                        ]
                      ),
                     ),
                     const SizedBox(width: 10,),
                     SizedBox(
                      height: 230,
                      width: 170,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('asset/images/bus1.png',
                            height: 160,
                            width: 170,
                            fit: BoxFit.fill,
                            ),
                  
                          ),
                          const Row(
                            children: [
                              Text('Book your Bus ',style: TextStyle(color: textColor,fontSize: 16,fontWeight: FontWeight.bold),),
                              Icon(Icons.arrow_forward_rounded)
                            ],
                          ),
                          const Text("Let's go for a trip",style:  TextStyle(color: textColor,fontSize: 14,),)
                        ]
                      ),
                     ),
                    ],
                  ),
                ),
              );
  }
}