import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/model/university_model.dart';

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
      this.margin,
      this.itemMargin,
      this.buttonTheme,
      this.buttonTextStyle})
      : super(key: key);

  final controller;
  final validator;
  final label;
  final buttonOnPress;
  final margin;
  final itemMargin;
  final buttonTheme;
  final buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: TextFormField(
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                    labelText: label, border: OutlineInputBorder()),
              )),
          Expanded(
              flex: 2,
              child: Container(
                margin: itemMargin,
                child: ElevatedButton(
                    style: buttonTheme,
                    onPressed: buttonOnPress,
                    child: Text("Verify", style: buttonTextStyle)),
              ))
        ],
      ),
      margin: margin,
    );
  }
}

class SelectBox extends StatelessWidget {
  SelectBox(
      {Key? key,
      this.validator,
      this.onChange,
      this.items,
      this.label,
      this.margin})
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
      child: DropdownButtonFormField<Object?>(
        itemHeight: 60,
        validator: (text) => validator(text),
        items: items
            .map<DropdownMenuItem<Object?>>((item) =>
                DropdownMenuItem<Object?>(child: Text(item.name), value: item))
            .toList(),
        onChanged: (Object? value) => onChange(value),
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
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
      this.buttonOnPress,
      this.itemMargin,
      this.textStyle,
      this.buttonTheme,
      this.buttonTextStyle})
      : super(key: key);

  final validator;
  final label;
  final margin;
  final controller;
  final domain;
  final buttonOnPress;
  final itemMargin;
  final textStyle;
  final buttonTheme;
  final buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller,
                validator: (text) => validator(text),
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(),
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                  margin: itemMargin,
                  child: Text(
                    '@' + domain,
                    style: textStyle,
                  ))),
          Expanded(
              flex: 2,
              child: Container(
                margin: itemMargin,
                child: ElevatedButton(
                    style: buttonTheme,
                    onPressed: buttonOnPress,
                    child: Text("Get Code", style: buttonTextStyle,)),
              ))
        ],
      ),
      margin: margin,
    );
  }
}
