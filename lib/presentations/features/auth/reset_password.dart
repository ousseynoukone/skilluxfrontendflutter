import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/validators/email_validator.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.widgets.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

class ResetAccount extends StatefulWidget {
  const ResetAccount({super.key});

  @override
  _ResetAccountState createState() => _ResetAccountState();
}

class _ResetAccountState extends State<ResetAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GetXAuthController _getXAuthController = Get.find();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line

      appBar: AppBar(
        title: Text(text.resetAccount),
      ),
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text.emailMessageFutur,
                style: textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Form(
                  key: _formKey,
                  child: TextFormFieldComponent(
                    controller: _emailController,
                    hintText: text.existingEmail,
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: text.email,
                    validator: (value) {
                      // Use EmailValidator for email validation
                      var message = EmailValidator.validate(value);
                      if (message != null) {
                        return message;
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Obx(() => ButtonComponent(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text.trim();
                          _getXAuthController.forgotPassword(email);

                          // Optionally clear the email field if sending email is successful
                          if (_getXAuthController.isSuccess.value) {
                            _emailController.clear();
                          }
                        }
                      },
                      text: text.sendEmail,
                      isLoading: _getXAuthController.isLoading.value,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
