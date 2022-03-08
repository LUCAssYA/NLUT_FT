import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.validator,
      this.label,
      this.margin,
      this.controller,
      this.obscure,
      this.suggestion,
      this.autoCorrect})
      : super(key: key);
  final validator;
  final label;
  final margin;
  final controller;
  final obscure;
  final suggestion;
  final autoCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (text) => validator(text),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        obscureText: obscure,
        enableSuggestions: suggestion,
        autocorrect: autoCorrect,
      ),
      margin: margin,
    );
  }
}

class TextFormFieldWithButton extends StatelessWidget {
  const TextFormFieldWithButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SelectBox extends StatelessWidget {
  SelectBox({Key? key, this.validator, this.onChange, this.items}) : super(key: key);
  final validator;
  final onChange;
  final items;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField<String?>(
        validator: (text) => validator(text),
        items: items.map<DropdownMenuItem<String?>>((item) => DropdownMenuItem<String?>(child: Text(item), value: item)).toList(),
        onChanged: (Object? value) => onChange(value),
      ),
    );
  }
}

