import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DislikeButton extends StatelessWidget {
  final bool isDisliked;
  void Function()? onTap;

  DislikeButton({super.key, required this.isDisliked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.arrow_downward_rounded,
        color: isDisliked ? Colors.red : Colors.grey,
      )
    );
  }
}