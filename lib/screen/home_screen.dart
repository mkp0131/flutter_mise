import 'package:flutter/material.dart';
import 'package:flutter_mise/component/main_app_bar.dart';
import 'package:flutter_mise/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: CustomScrollView(
          slivers: [
            MainAppBar(),
          ],
        ));
  }
}
