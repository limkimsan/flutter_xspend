import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        EasyLoading.show(status: 'Loading...');
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
          const InputLabelWidget('Your name'),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length >= 50) {
                return 'Must be between 1 and 50 characters long.';
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
          const InputLabelWidget('Your email'),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
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
          ),
          const SizedBox(height: 24),
          const InputLabelWidget('Your password'),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Must be at least 6 characters';
              }
              return null;
            },
            onChanged: (value) {
              _password = value;
            },
          ),
          const SizedBox(height: 24),
          const InputLabelWidget('Confirm password'),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              errorMaxLines: 2,
              hintText: 'Enter confirm password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm password is required';
              }
              if (value != _password) {
                return 'Confirm password and password are not matched.';
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
              child: const Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}