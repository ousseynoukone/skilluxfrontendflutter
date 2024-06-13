import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/validators/email_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/full_name_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/login_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/password_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/username_validator.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.widgets.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var text = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _fullNameController,
                  hintText: text.enterFullName,
                  labelText: text.fullName,
                  validator: (value) {
                    var message = FullNameValidator.validate(value);
                    if (value == null || message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _usernameController,
                  hintText: text.enterUsername,
                  labelText: text.username,
                  validator: (value) {
                    var message = UsernameValidator.validate(value);
                    if (value == null || message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _emailController,
                  hintText: text.enterEmail,
                  labelText: text.email,
                  validator: (value) {
                    // Use LoginValidator for email validation
                    var message = EmailValidator.validate(value);
                    if (message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _passwordController,
                  hintText: text.enterYourPassword,
                  labelText: text.password,
                  obscureText: true,
                  validator: (value) {
                    var message = PasswordValidator.validate(value);
                    if (value == null || message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ButtonComponent(
                  onPressed: () {
                    // Validate the form before submitting
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with registration logic
                      String fullName = _fullNameController.text.trim();
                      String username = _usernameController.text.trim();
                      String email = _emailController.text.trim();
                      String password = _passwordController.text;
                      String birthDate = _birthController.text.trim();

                      // Implement your registration logic here
                      print('Full Name: $fullName');
                      print('Username: $username');
                      print('Email: $email');
                      print('Password: $password');
                      print('Birth Date: $birthDate');
                    }
                  },
                  text: text.register,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
