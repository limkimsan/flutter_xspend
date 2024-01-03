import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Text(
                'KHR 0',
                style: TextStyle(color: Colors.yellow, fontSize: 18),
              ),
              Text(
                '\$0.00',
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}