import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_xspend/src/home/home_view.dart';
import 'package:flutter_xspend/src/login/login_controller.dart';
import 'package:flutter_xspend/src/widgets/input_label_widget.dart';
import 'package:flutter_xspend/src/constants/colors.dart';

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
        EasyLoading.show(status: 'Loading...');
        LoginController.login(_email, _password, () {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName, (route) => false);
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
          const InputLabelWidget('Email'),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter the email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                return 'Please enter a valid email address.';
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
          const InputLabelWidget('Password'),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter the password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'Password is required.';
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
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}