import 'package:flutter/material.dart';

class TextCenter extends StatefulWidget {
  final String? text;

  final double fontSize;

  final double margin;

  final FontWeight fontWeight;

  const TextCenter(
      {Key? key,
      this.text,
      this.fontSize = 20,
      this.margin = 40,
      this.fontWeight = FontWeight.normal});
  @override
  State<TextCenter> createState() => _TextCenterState();
}

class _TextCenterState extends State<TextCenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.margin),
      child: Text(
        widget.text!,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontSize: widget.fontSize, fontWeight: widget.fontWeight),
      ),
    );
  }
}
