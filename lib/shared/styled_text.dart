import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  const StyledText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium,);
  }
}

class StyledHeading extends StatelessWidget {
  final String text;
  const StyledHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium);
  }
}

class StyledTitle extends StatelessWidget {
  final String text;
  const StyledTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: Theme.of(context).textTheme.titleMedium,);
  }
}