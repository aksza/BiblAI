import 'package:flutter/material.dart';
import 'package:flutter_fe/models/verse_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomVerseButton extends StatelessWidget {
  final Verse verse;
    
  const CustomVerseButton({
    super.key,
    required this.verse,
    });

  @override
  Widget build(BuildContext context) {
    String verseText = "${verse.book} ${verse.chapter} : ${verse.verse}";

    return GestureDetector(
      onTap: () {
          if (verse.link != null && verse.link!.isNotEmpty) {
            launchUrl(Uri.parse(verse.link));
          }
        },
    
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
                verseText,
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