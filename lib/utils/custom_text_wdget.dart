import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;

  const CustomTextWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: 'Jost', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Text(
          subtitle,
          style: TextStyle(fontFamily: 'Jost', fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        Text(
          description,
          style: TextStyle(fontFamily: 'Jost', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
        ),
      ],
    );
  }
}
