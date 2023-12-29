import 'package:flutter/material.dart';

import 'sign_up_form_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 40),
            const SignUpFormWidget(),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Sign Up'),
              ),
            )
          ],
        ),
      ),
    );


    // return Scaffold(
    //   appBar: AppBar(title: const Text('ttlajsdlkjfaldjf')),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Text(
    //           'Sign Up',
    //           style: Theme.of(context).textTheme.headlineLarge,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}