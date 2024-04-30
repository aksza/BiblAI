import 'package:flutter/material.dart';
import 'package:flutter_fe/models/verse_model.dart';

class CustomVerse extends StatelessWidget {
  final Verse verse;

  const CustomVerse({
    Key? key,
    required this.verse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String verseText = "${verse.book} ${verse.chapter} : ${verse.verse}";

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            verseText,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}