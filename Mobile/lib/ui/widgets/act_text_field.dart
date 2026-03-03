import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ACTTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool hasValidationError;
  final String? hintText;
  final String? labelText;
  final bool isReadOnly;
  final String errorText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final double maxWidth;
  final Widget? label;
  final FloatingLabelAlignment floatingLabelAlignment;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextAlign textAlign;
  final int? maxLines;
  final bool isDense;
  final bool isFilled;
  final bool isEnabled;
  final bool validate;
  final bool obscure;
  final Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;

  const ACTTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.hasValidationError = false,
    this.hintText,
    this.labelText,
    this.isReadOnly = false,
    this.errorText = 'Required',
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.maxWidth = 400,
    this.label,
    this.floatingLabelAlignment = FloatingLabelAlignment.start,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.isDense = true,
    this.isFilled = true,
    this.isEnabled = true,
    this.validate = false,
    this.obscure = false,
    this.validator,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    AppTextTheme textTheme = sl.themeCubit.state.main.colorTheme.textStyles;
    AppTheme theme = sl.themeCubit.state.main.colorTheme.theme;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: kIsWeb ? maxWidth : double.infinity),
      child: TextFormField(
        cursorColor: theme.primary,
        decoration: InputDecoration(
          label: label,
          hintText: hintText,
          labelText: labelText,
          errorText: hasValidationError ? errorText : null,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          floatingLabelAlignment: floatingLabelAlignment,
          floatingLabelBehavior: floatingLabelBehavior,
          isDense: isDense,
          filled: isFilled,
        ),
        enabled: isEnabled,
        style: textTheme.text4,
        controller: controller,
        readOnly: isReadOnly,
        autocorrect: false,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        focusNode: focusNode,
        textAlign: textAlign,
        maxLines: maxLines,
        canRequestFocus: true,
        validator: validator != null ? (value) => validator!(value) : (value) => (validate ? ((value ?? '').isEmpty ? 'Required' : null) : null),
        obscureText: obscure,
        inputFormatters: inputFormatter,
      ),
    );
  }
}
