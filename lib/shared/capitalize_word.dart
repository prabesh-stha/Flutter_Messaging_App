import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/shared/styled_text.dart';

enum StyleOfText{
  title,
  heading,
  body,
}

class CapitalizeWord extends StatelessWidget {
  final String text;
  final StyleOfText styleOfText;
  const CapitalizeWord({super.key, required this.text, required this.styleOfText});

  String capitalize(){
   return text.split(' ').map((word){
      if(word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
  @override
  Widget build(BuildContext context) {
    switch(styleOfText){
      case StyleOfText.title:
        return StyledTitle(text: capitalize());
      case StyleOfText.heading:
        return StyledHeading(text: capitalize());
      case StyleOfText.body:
        return StyledText(text: capitalize());
      default:
        return StyledText(text: text);

    }
  }
}