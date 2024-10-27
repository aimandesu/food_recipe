import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.title = '',
    this.marked = '',
    this.hintText = '',
    this.keyboardType,
    this.textStyleTitle,
    this.controller,
    this.maxline = 1,
    this.readOnly = false,
    this.hintStyle,
    this.validator,
    this.inputFormatters,
    this.padding = const EdgeInsets.only(top: 10, bottom: 30),
    this.focusNode,
  });

  final String title;
  final String marked;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextStyle? textStyleTitle;
  final TextEditingController? controller;
  final int? maxline;
  final bool readOnly;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry padding;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title == '')
          const SizedBox.shrink()
        else
          Row(
            children: [
              Text(title, style: textStyleTitle),
              if (marked != '')
                Text(
                  marked,
                  style: textStyleTitle?.copyWith(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        Padding(
          padding: padding,
          child: TextFormField(
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            readOnly: readOnly,
            maxLines: maxline,
            controller: controller,
            keyboardType: keyboardType,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            validator: validator ??
                (String? val) {
                  if (val == null || val.trim().isEmpty) {
                    return '$title cannot be empty';
                  } else {
                    return null;
                  }
                },
            decoration: InputDecoration(
              hintStyle: hintStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[20],
                      ),
              hintText: hintText,
              isDense: true,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.pink,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
