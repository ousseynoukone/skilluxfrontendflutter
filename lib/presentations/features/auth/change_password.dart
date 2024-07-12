import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/validators/password_validator.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GetXAuthController _getXAuthController = Get.find();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isObscureNew = true;
  bool _isObscureOld = true;

  late FocusNode _oldPasswordFocus;
  late FocusNode _newPasswordFocus;

  @override
  void initState() {
    super.initState();
    _oldPasswordFocus = FocusNode();
    _newPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _oldPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    super.dispose();
  }

  void clearControllers() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
  }

  void _toggleVisibility(bool isOld) {
    setState(() {
      if (isOld) {
        _isObscureOld = !_isObscureOld;
      } else {
        _isObscureNew = !_isObscureNew;
      }
    });
  }

  void _showConfirmationDialog() {
    var text = context.localizations;

    Get.dialog(
      ConfirmationDialog(
        title: text.confirmPasswordChange,
        content: text.areYouSureChangePassword,
        onConfirm: () {
          String oldPassword = _oldPasswordController.text;
          String newPassword = _newPasswordController.text;
          _getXAuthController.changePassword(newPassword, oldPassword);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(text.changePassword),
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
                    focusNode: _oldPasswordFocus,
                    controller: _oldPasswordController,
                    hintText: text.enterYourOldPassword,
                    labelText: text.oldPassword,
                    obscureText: _isObscureOld,
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: IconButton(
                        icon: _isObscureOld
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          _toggleVisibility(true);
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
                  child: TextFormFieldComponent(
                    focusNode: _newPasswordFocus,
                    controller: _newPasswordController,
                    hintText: text.enterYourNewPassword,
                    labelText: text.newPassword,
                    obscureText: _isObscureNew,
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: IconButton(
                        icon: _isObscureNew
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          _toggleVisibility(false);
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
                        // Validate the form before showing confirmation dialog
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          _showConfirmationDialog();
                        }
                      },
                      text: text.changePassword,
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
