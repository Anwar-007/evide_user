import 'package:flutter/material.dart';

class TopnavigationButton extends StatelessWidget {
  
  final Image image;

final  VoidCallback onTap;

  const TopnavigationButton(
      {super.key,
     
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 80,
      width: 70,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(15),
              child: image,
            ),
            
          ],
        ),
      ),
    );
  }
}
