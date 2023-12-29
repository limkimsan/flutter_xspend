import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/widgets/input_label_widget.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  @override
  Widget build(BuildContext context) {
    void login() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
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