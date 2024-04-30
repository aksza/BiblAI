import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Icon icon;
    
  const MyPostButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    });

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
    
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: 
          Row(
            children:[
              icon,
              const SizedBox(width: 8), 
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              )
              ]
          ),
        ),
      ),
    );
  }
}