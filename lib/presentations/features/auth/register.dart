import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skilluxfrontendflutter/config/validators/birth_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/email_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/full_name_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/password_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/username_validator.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_register_dto.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/date_picker.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.widgets.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_register_controller.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final GetXAuthController _getXAuthController = Get.find();

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _birthFocusNode = FocusNode();

  bool _isObscure = true;

  void _toggleVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _birthController.dispose();
    _fullNameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _birthFocusNode.dispose();
    super.dispose();
  }

  void _clearControllers() {
    _fullNameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _birthController.clear();
  }

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
                  focusNode: _fullNameFocusNode,
                  hintText: text.enterFullName,
                  prefixIcon: const Icon(Icons.person_outlined),
                  labelText: text.fullName,
                  validator: (value) {
                    var message = FullNameValidator.validate(value);
                    if (value == null || message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_usernameFocusNode);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  hintText: text.enterUsername,
                  prefixIcon: const Icon(Icons.person_outlined),
                  labelText: text.username,
                  validator: (value) {
                    var message = UsernameValidator.validate(value);
                    if (value == null || message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DatePickerComponent(
                      datePickerController: _birthController,
                      focusNode: _birthFocusNode,
                      hintText: text.enterBirth,
                      labelText: text.birth,
                      validator: (value) {
                        var message = BirthDateValidator.validate(value);
                        if (value == null || message != null) {
                          return message;
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  hintText: text.enterEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: text.email,
                  validator: (value) {
                    // Use LoginValidator for email validation
                    var message = EmailValidator.validate(value);
                    if (message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() => ButtonComponent(
                      onPressed: () {
                        // Validate the form before submitting
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, proceed with registration logic
                          String fullName = _fullNameController.text.trim();
                          String username = _usernameController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text;
                          String birth = DateFormat('yyyy-MM-dd', 'en').format(
                              DateTime.parse(_birthController.text.trim()));

                          // Creating userRegisterDto
                          UserRegisterDto userRegisterDto = UserRegisterDto(
                              username: username,
                              fullName: fullName,
                              password: password,
                              birth: birth,
                              email: email);

                          // Calling register method from _getXAuthController
                          _getXAuthController.register(userRegisterDto);

                          if (_getXAuthController.isSuccess.value) {
                            _clearControllers();
                            FocusScope.of(context).unfocus();
                          }
                        }
                      },
                      text: text
                          .register, // Assuming 'text.register' is your localized register button text
                      isLoading: _getXAuthController.isLoading
                          .value, // Pass the isLoading state from _getXAuthController
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
