import 'package:flutter/material.dart';

class GenericDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String Function(T) itemLabel;
  final Function(T) onChanged;
  final String? hint;
  final Color dropdownColor;
  final Color itemColor;
  final Color borderColor;
  final Color? hintTextColor;
  final double borderRadius;
  final double padding;

  const GenericDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.hint,
    this.dropdownColor = Colors.white,
    this.itemColor = Colors.black,
    this.borderColor = Colors.grey,
    this.hintTextColor,
    this.borderRadius = 8.0,
    this.padding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        color: dropdownColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedValue,
          hint: hint != null
              ? Text(
                  hint!,
                  style: TextStyle(color: hintTextColor ?? Colors.grey),
                )
              : null,
          isExpanded: false,
          dropdownColor: dropdownColor,
          items: items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                style: TextStyle(color: itemColor),
              ),
            );
          }).toList(),
          onChanged: (T? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          icon: Icon(Icons.arrow_drop_down, color: itemColor),
        ),
      ),
    );
  }
}
