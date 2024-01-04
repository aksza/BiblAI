import 'package:flutter/material.dart';

class CustomRecommendButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
    
  const CustomRecommendButton({
    super.key,
    required this.onTap,
    required this.text,
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