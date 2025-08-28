import 'package:flutter/material.dart';

import '../../Cores/colors.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.onTap,  required this.icon});
  final VoidCallback onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
                leading: GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      'asset/images/logo1.jpg',
                    ),
                  ),
                ),
                title: const Text('Your location',style: TextStyle(fontSize: 12),),
                subtitle: const Text(
                  'Kochi, Kerala',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor),
                ),
                
                trailing: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 247, 247, 247),
                  radius: 50,
                  child: IconButton(
                      onPressed: () {},
                      icon: icon),
                ),
              );
  }
}