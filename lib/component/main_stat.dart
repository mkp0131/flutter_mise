import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  final String category;
  final String imgPath;
  final String level;
  final String stat;
  final double width;

  const MainStat({
    required this.category,
    required this.imgPath,
    required this.level,
    required this.stat,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(category),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 50,
            child: Image.asset(imgPath),
          ),
          SizedBox(
            height: 10,
          ),
          Text(level),
          Text('${stat}'),
        ],
      ),
    );
  }
}
