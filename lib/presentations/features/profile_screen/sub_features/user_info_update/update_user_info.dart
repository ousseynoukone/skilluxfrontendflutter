import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/validators/email_validator.dart';
import 'package:skilluxfrontendflutter/config/validators/full_name_validator.dart';

import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/helper/resend_activation_email.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/reset_password.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_update_service.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  final User user;
  const UpdateUserInfoScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserUpdateService _userUpdateService = Get.find();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  initUserInfo() {
    _fullNameController.text = widget.user.fullName;
    _emailController.text = widget.user.email;
    _professionController.text = widget.user.profession ?? "";
  }

  void clearControllers() {
    _emailController.clear();
    _fullNameController.clear();
    _professionController.clear();
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
                  controller: _fullNameController,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _emailController,
                  hintText: text.existingEmail,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormFieldComponent(
                  controller: _professionController,
                  hintText: text.professionHint,
                  prefixIcon: const Icon(Icons.person_outlined),
                  labelText: text.profession,
                  validator: (value) {
                    var message = FullNameValidator.validate(value);
                    if (value == null || message != null) {
                      return message;
                    }
                    return null; // Return null if the input is valid
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus();
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.center,
                  child: Obx(
                    () => OutlineButtonComponent(
                      iconColor: ColorsTheme.secondary,
                      edgeInsets: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      icon: Icons.publish,
                      onPressed: () {
                        // Validate the form before submitting
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          // FocusManager.instance.primaryFocus?.unfocus();

                          String email = _emailController.text.trim();
                          String fullName = _fullNameController.text.trim();
                          String profession = _professionController.text.trim();

                          _userUpdateService.updateUserInfos(
                              fullName, profession, email);
                        }
                      },
                      text: text.update,
                      isLoading: _userUpdateService.isLoading.value,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
