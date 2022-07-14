import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/model/university_model.dart';
import 'package:urooster/style/widget_style.dart' as style;

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
      this.onChange,
      this.onSave,
      this.value})
      : super(key: key);
  final validator;
  final label;
  final margin;
  final controller;
  final obscure;
  final suggestion;
  final autoCorrect;
  final onChange;
  final onSave;
  final value;

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
        onSaved: (value) => onSave(value),
        initialValue: value,
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
      this.margin,
      this.value})
      : super(key: key);
  final validator;
  final onChange;
  final items;
  final label;
  final margin;
  final value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: DropdownButtonFormField<Object?>(
        value: value,
        itemHeight: 80,
        validator: (text) => validator(text),
        items: items
            .map<DropdownMenuItem<Object?>>((item) => DropdownMenuItem<Object?>(
                  child: Container(
                      margin: style.dropDownItemMargin, child: Text(item.name)),
                  value: item,
                ))
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
                    child: Text(
                      "Get Code",
                      style: buttonTextStyle,
                    )),
              ))
        ],
      ),
      margin: margin,
    );
  }
}

class TextFieldWithCalender extends StatelessWidget {
  TextFieldWithCalender(
      {Key? key, this.checked, this.controller, this.validator, this.label})
      : super(key: key);

  final controller;
  final validator;
  final label;
  late final checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style.calendarWidth(context),
      margin: style.calendarMargin,
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: controller,
            validator: (text) => validator(text),
            decoration:
                InputDecoration(labelText: label, border: OutlineInputBorder()),
            readOnly: true,
            onTap: () {
              print("tap");
            },
          )),
          Container(
              margin: style.iconMargin,
              child: Icon(Icons.calendar_today_outlined)),
        ],
      ),
    );
  }
}

class DisabledTextBox extends StatelessWidget {
  DisabledTextBox(
      {Key? key,
      this.width,
      this.margin,
      this.controller,
      this.label,
      this.onTap,
      this.onSave})
      : super(key: key);

  final width;
  final margin;
  final controller;
  final label;
  final onTap;
  final onSave;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        readOnly: true,
        onTap: () => onTap(),
        onSaved: (value) => onSave(),
      ),
    ));
  }
}
