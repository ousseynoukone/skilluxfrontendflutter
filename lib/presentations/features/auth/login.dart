import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/validators/login_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/password_validator.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_dto.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/helper/resend_activation_email.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/reset_password.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/helper/helper.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GetXAuthController _getXAuthController = Get.find();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  late FocusNode _loginFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _loginFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _loginFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void clearControllers() {
    _loginController.clear();
    _passwordController.clear();
  }

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
                  focusNode: _loginFocus,
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
                  focusNode: _passwordFocus,
                  controller: _passwordController,
                  hintText: text.enterYourPassword,
                  labelText: text.password,
                  obscureText: _isObscure,
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      icon: _isObscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off_outlined),
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
                  onFieldSubmitted: (string) {
                    _login();
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Obx(
                    () => ButtonComponent(
                      onPressed: () {
                        _login();
                      },
                      text: text.login,
                      isLoading: _getXAuthController.isLoading.value,
                    ),
                  )),
              bottomComponent(text, textTheme, _getXAuthController)
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    // Validate the form before submitting
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      // Form is valid, proceed with login logic
      String login = _loginController.text.trim();
      String password = _passwordController.text;
      late UserLoginDto loginDto;

      if (AuthHelper.isUsername(login)) {
        loginDto = UserLoginDto(password: password, username: login, email: "");
      } else {
        loginDto = UserLoginDto(password: password, email: login, username: "");
      }

      _getXAuthController.login(loginDto);
    }
  }
}

Widget bottomComponent(var text, var textTheme, var getXAuthController) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          // For wider screens, use a Row
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildForgotPasswordText(text, textTheme),
              ),
              Flexible(
                child: _buildResendActivationEmail(
                    text, textTheme, getXAuthController),
              ),
            ],
          );
        } else {
          // For narrower screens, use a Column
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildForgotPasswordText(text, textTheme),
              const SizedBox(height: 8),
              _buildResendActivationEmail(text, textTheme, getXAuthController),
            ],
          );
        }
      },
    ),
  );
}

Widget _buildForgotPasswordText(var text, var textTheme) {
  return InkWell(
    onTap: () {
      Get.bottomSheet(const ResetAccount());
    },
    child: Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: text.forgotYour,
            style: textTheme.bodySmall,
          ),
          TextSpan(
            text: text.passwordQuestion,
            style: textTheme.bodySmall.copyWith(
              color: ColorsTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );
}

Widget _buildResendActivationEmail(
    var text, var textTheme, var getXAuthController) {
  return Obx(
    () => !getXAuthController.isLoading.value
        ? InkWell(
            onTap: () {
              resendActivationEmail();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: ColorsTheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    text.resendActivationEmail,
                    style: textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink(),
  );
}
