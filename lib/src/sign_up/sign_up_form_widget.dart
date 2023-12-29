import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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
  var _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    Widget inputLabel(String label) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      );
    }

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputLabel('Your name'),
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
            }
          ),
          const SizedBox(height: 24),
          inputLabel('Your email'),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || EmailValidator.validate(value)) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          const SizedBox(height: 24),
          inputLabel('Your password'),
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
            onSaved: (value) {
              _password = value!;
            },
          ),
          const SizedBox(height: 24),
          inputLabel('Confirm password'),
          TextFormField(
            decoration: const InputDecoration(
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
            onSaved: (value) {
              _confirmPassword = value!;
            }
          ),
        ],
      ),
    );
  }
}