import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'KHR 0',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              '\$0.00',
              style: TextStyle(color: lightGreen, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}