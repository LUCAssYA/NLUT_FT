import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/register_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/widget/text_field.dart';
import 'package:urooster/style/register_style.dart' as style;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegisterProvider>().getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [Header(), Body()],
        ),
      )),
    );
  }
}

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Register"),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          validator: context.read<RegisterProvider>().defaultValidator,
          label: "name",
          margin: style.textMargin,
          controller: nameController,
          obscure: false,
          suggestion: true,
          autoCorrect: true,
        ),
        SelectBox(
          validator: context.read<RegisterProvider>().defaultValidator,
          items: context.read<RegisterProvider>().universities.keys.toList(),
          onChange: context.read<RegisterProvider>().uniOnChange,
        ),
        SelectBox(
          validator: context.read<RegisterProvider>().defaultValidator,
          items: Provider.of<RegisterProvider>(context).faculties,
          onChange: () {},
        )
      ],
    );
  }
}
