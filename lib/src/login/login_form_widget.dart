import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/bottom_tab/bottom_tab_view.dart';
import 'package:flutter_xspend/src/login/login_controller.dart';
import 'package:flutter_xspend/src/widgets/input_label_widget.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    void login() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          errorMsg = '';
        });
        EasyLoading.show(status: AppLocalizations.of(context)!.loading);
        LoginController.login(_email, _password, () {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, BottomTabView.routeName, (route) => false);
        }, (errorMessage) {
          EasyLoading.dismiss();
          setState(() {
            errorMsg = errorMessage;
          });
        });
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabelWidget(AppLocalizations.of(context)!.email),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterYourEmail,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                return AppLocalizations.of(context)!.pleaseEnterAValidEmailAddress;
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 24),
          InputLabelWidget(AppLocalizations.of(context)!.yourPassword),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterYourPassword,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.passwordIsRequired;
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          const SizedBox(height: 48),
          if (errorMsg.isNotEmpty)
            Center(
              child: Text(
                errorMsg,
                style: const TextStyle(color: red),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: login,
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ),
          ),
        ],
      ),
    );
  }
}