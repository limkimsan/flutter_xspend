import 'package:flutter/material.dart';

import 'login_form_widget.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/sign_up/sign_up_view.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/xpense-icon.png',
            //   width: 150,
            //   height: 150,
            // ),
            SizedBox(
              height:200,
              child: Stack(
                // alignment: Alignment.center,
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'assets/images/xpense-icon.png',
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                  ),
                  const Positioned(
                    top: 115,
                    // left: -widget.width / 2,
                    // right: widget.width / 2,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('X',
                          style: TextStyle(
                            color: primary,
                            fontSize: 36,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('pense',
                          style: TextStyle(
                            color: primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            ),
            const LoginFormWidget(),
            const SizedBox(height: 26),
            const Row(
              children: [
                Expanded(child: Divider(endIndent: 12, color: darkGrey)),
                Text('OR', style: TextStyle(color: darkGrey)),
                Expanded(child: Divider(indent: 12, color: darkGrey)),
              ],
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, SignUpView.routeName, (route) => false);
                },
                child: const Text('Create new account', style: TextStyle(fontWeight: FontWeight.bold))
              ),
            )
          ],
        ),
      ),
    );
  }
}