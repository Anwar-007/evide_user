import 'package:evide_user/core/utils/app_imports.dart';

class CommonTextFormFieldWidget extends StatelessWidget {
  const CommonTextFormFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.cursorColor,
    this.onTap,
    this.maxLines,
    this.obscureText,
    this.showCursor,
    this.enabled,
    this.focusNode,
    this.validator,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.prefixWidget,
    this.suffixWidget,
    this.filled,
    this.labelText,
    this.labelStyle,
    this.fillColor,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final Color? cursorColor;
  final void Function()? onTap;
  final int? maxLines;
  final bool? obscureText;
  final bool? showCursor;
  final bool? enabled;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool? filled;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: cursorColor,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      focusNode: focusNode,
      validator: validator,
      inputFormatters: [],
      obscureText: obscureText ?? false,
      showCursor: showCursor ?? true,
      decoration: InputDecoration(
        hintText: hintText,
        border: border,
        focusedBorder: focusedBorder ?? border,
        errorBorder: errorBorder ?? border,
        disabledBorder: disabledBorder ?? border,
        prefix: prefixWidget,
        suffix: suffixWidget,
        filled: filled,
        labelText: labelText,
        labelStyle: labelStyle,
        fillColor: fillColor,
        enabledBorder: enabledBorder ?? border,
      ),
    );
  }
}
