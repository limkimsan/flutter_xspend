import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/sign_up/sign_up_controller.dart';
import 'package:flutter_xspend/src/widgets/input_label_widget.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/bottom_tab/bottom_tab_view.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _email = '';
  var _password = '';
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    void signUp() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          errorMsg = '';
        });
        EasyLoading.show(status: AppLocalizations.of(context)!.loading);
        SignUpController.signUp(_name, _email, _password, () {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, BottomTabView.routeName, (route) => false);
        }, (errorMsg) {
          EasyLoading.dismiss();
          setState(() {
            errorMsg = errorMsg;
          });
        });
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabelWidget(AppLocalizations.of(context)!.yourName),
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterYourName,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length >= 50) {
                return AppLocalizations.of(context)!.mustBeAtLeastSixCharacters;
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 24),
          InputLabelWidget(AppLocalizations.of(context)!.yourEmail),
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
          ),
          const SizedBox(height: 24),
          InputLabelWidget(AppLocalizations.of(context)!.yourPassword),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterYourPassword,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return AppLocalizations.of(context)!.mustBeAtLeastSixCharacters;
              }
              return null;
            },
            onChanged: (value) {
              _password = value;
            },
          ),
          const SizedBox(height: 24),
          InputLabelWidget(AppLocalizations.of(context)!.confirmPassword),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              errorMaxLines: 2,
              hintText: AppLocalizations.of(context)!.enterConfirmPassword,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.confirmPasswordIsRequired;
              }
              if (value != _password) {
                return AppLocalizations.of(context)!.confirmPasswordAndPasswordAreNotMatched;
              }
              return null;
            },
          ),
          const SizedBox(height: 48),
          if (errorMsg.isNotEmpty)
            Center(
              child: Text(
                errorMsg,
                style: const TextStyle(color: red,),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: signUp,
              child: Text(
                AppLocalizations.of(context)!.signUp,
                style: Theme.of(context).textTheme.titleMedium
              ),
            ),
          ),
        ],
      ),
    );
  }
}