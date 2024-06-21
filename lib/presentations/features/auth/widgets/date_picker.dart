import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';

class DatePickerComponent extends StatefulWidget {
  final TextEditingController datePickerController;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const DatePickerComponent({
    Key? key,
    required this.datePickerController,
    required this.hintText,
    required this.validator,
    required this.labelText,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _DatePickerComponentState createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  DateTime? _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? newDateTime = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height / 2.5,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Container(
                height: Get.height / 3.3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  minimumDate: DateTime(DateTime.now().year - 100),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CupertinoButton(
                  color: ColorsTheme.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (_selectedDate != null) {
                      // Get the current locale
                      Locale currentLocale = Localizations.localeOf(context);

                      // Format date based on locale
                      String formattedDate;
                      if (currentLocale.languageCode == 'fr') {
                        formattedDate = DateFormat('dd-MM-yyyy', 'fr')
                            .format(_selectedDate!);
                      } else {
                        formattedDate = DateFormat('yyyy-MM-dd', 'en')
                            .format(_selectedDate!);
                      }

                      widget.datePickerController.text = formattedDate;
                    }
                  },
                  child: Text(
                    context.localizations.ok,
                    style: const TextStyle(color: ColorsTheme.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldComponent(
      ontap: () {
        // Prevent keyboard
        FocusScope.of(context).requestFocus(FocusNode());
        // Select date function
        _selectDate(context);
      },
      prefixIcon: const Icon(Icons.date_range_outlined),
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.datePickerController,
      readOnly: true,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
