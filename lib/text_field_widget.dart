import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final Icon icon;
  final TextEditingController controller;
  final TextInputType type;
  const TextFieldWidget(
      {required this.icon,
      required this.title,
      required this.controller,
      required this.type,
      super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Please enter some text';
          }
          return null;
        },
        textAlign: TextAlign.center,
        keyboardType: widget.type,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        maxLength: 25,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            label: ListTile(
              leading: widget.icon,
              title: Text(widget.title),
            ),
            counterText: ''),
      ),
    );
  }
}
