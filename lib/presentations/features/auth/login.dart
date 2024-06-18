import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/validators/login_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/password_validator.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.widgets.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  void _toggleVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
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
                  controller: _loginController,
                  hintText: text.enterYourEmailOrUsername,
                  labelText: text.login,
                  prefixIcon: const Icon(Icons.login_outlined),
                  validator: (value) {
                    var message = LoginValidator.validate(value);
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
                  controller: _passwordController,
                  hintText: text.enterYourPassword,
                  labelText: text.password,
                  obscureText: _isObscure,
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      icon: _isObscure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off_outlined),
                      onPressed: () {
                        _toggleVisibility();
                      },
                    ),
                  ),
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
                      // Form is valid, proceed with login logic
                      String login = _loginController.text.trim();
                      String password = _passwordController.text;
                      // Implement your login functionality here
                      print('Login: $login, Password: $password');
                    }
                  },
                  text: text.login,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Implement forgot password logic here
                },
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: text.forgotYour,
                        style: textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: text.passwordQuestion,
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorsTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
