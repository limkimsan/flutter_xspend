import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_form_widget.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/sign_up/sign_up_view.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,    // when keyboard is showing, it will not push the content
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 56),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:200,
                  child: Stack(
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
                        child: Row(
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
                Row(
                  children: [
                    const Expanded(child: Divider(endIndent: 12, color: darkGrey)),
                    Text(AppLocalizations.of(context)!.or, style: const TextStyle(color: darkGrey)),
                    const Expanded(child: Divider(indent: 12, color: darkGrey)),
                  ],
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, SignUpView.routeName, (route) => false);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.createNewAccount,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: primary
                      )
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}