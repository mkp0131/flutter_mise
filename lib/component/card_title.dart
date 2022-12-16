import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  const CardTitle({
    required this.title,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
