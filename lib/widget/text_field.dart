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
      this.autoCorrect,
      this.onChange})
      : super(key: key);
  final validator;
  final label;
  final margin;
  final controller;
  final obscure;
  final suggestion;
  final autoCorrect;
  final onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (text) => validator(text),
        onChanged: onChange,
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
  TextFormFieldWithButton(
      {Key? key,
      this.controller,
      this.validator,
      this.label,
      this.buttonOnPress,
      this.margin})
      : super(key: key);

  final controller;
  final validator;
  final label;
  final buttonOnPress;
  final margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: controller,
            validator: validator,
            decoration:
                InputDecoration(labelText: label, border: OutlineInputBorder()),
          )),
          Expanded(
              child: ElevatedButton(
                  onPressed: buttonOnPress, child: Text("Verify")))
        ],
      ),
      margin: margin,
    );
  }
}

class SelectBox extends StatelessWidget {
  SelectBox({Key? key, this.validator, this.onChange, this.items, this.label, this.margin})
      : super(key: key);
  final validator;
  final onChange;
  final items;
  final label;
  final margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: DropdownButtonFormField<String?>(
        validator: (text) => validator(text),
        items: items
            .map<DropdownMenuItem<String?>>((item) =>
                DropdownMenuItem<String?>(child: Text(item), value: item))
            .toList(),
        onChanged: (Object? value) => onChange(value),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder()
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField(
      {Key? key,
      this.validator,
      this.label,
      this.margin,
      this.controller,
      this.domain,
      this.buttonOnPress})
      : super(key: key);

  final validator;
  final label;
  final margin;
  final controller;
  final domain;
  final buttonOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: controller,
            validator: (text) => validator(text),
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          )),
          Expanded(child: Text('@' + domain)),
          Expanded(
              child: ElevatedButton(
                  onPressed: buttonOnPress,
                  child: Text("Get Code")))
        ],
      ),
      margin: margin,
    );
  }
}
