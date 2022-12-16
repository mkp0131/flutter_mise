import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const MainCard({
    required this.backgroundColor,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
