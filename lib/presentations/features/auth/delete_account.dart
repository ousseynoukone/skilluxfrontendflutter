import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/validators/password_validator.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GetXAuthController _getXAuthController = Get.find();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  void clearControllers() {
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(text.deleteAccount),
      ),
      body: SingleChildScrollView(
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
                    focusNode: passwordFocus,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Obx(
                    () => ButtonComponent(
                      onPressed: () {
                        // Validate the form before submitting
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();

                          // Show confirmation dialog before deleting account
                          Get.dialog(
                            ConfirmationDialog(
                              title: text.confirmDeleteAccount,
                              content: text.areYouSureDeleteAccount,
                              onConfirm: () {
                                String password = _passwordController.text;
                                _getXAuthController.deleteAccount(password);
                              },
                            ),
                          );
                        }
                      },
                      text: text.deleteAccount,
                      isLoading: _getXAuthController.isLoading.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
