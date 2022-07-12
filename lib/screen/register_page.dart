import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/register_provider.dart';
import 'package:urooster/widget/button.dart';
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
        margin: style.contextMargin(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
      margin: style.headerMargin,
      child: Text(
        "Register",
        style: style.headerStyle,
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final verifyController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final nickNameController = TextEditingController();

  static final rformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: rformKey,
        child: Column(
          children: [
            SelectBox(
              validator: context.read<RegisterProvider>().defaultValidator,
              items:
                  context.read<RegisterProvider>().universities,
              onChange: context.read<RegisterProvider>().uniOnChange,
              label: "University",
              margin: style.textMargin,
            ),
            SelectBox(
              validator: context.read<RegisterProvider>().defaultValidator,
              items: context.watch<RegisterProvider>().faculties,
              onChange: context.read<RegisterProvider>().facultyOnChange,
              label: "Faculty",
              margin: style.textMargin,
              value: context.watch<RegisterProvider>().faculty,
            ),
            EmailTextField(
                buttonTheme: style.buttonTheme,
                validator: context.read<RegisterProvider>().emailValidator,
                itemMargin: style.itemMargin,
                label: "Email",
                margin: style.textMargin,
                controller: emailController,
                domain: context.watch<RegisterProvider>().domain,
                textStyle: style.domainTextStyle,
                buttonOnPress: () => context
                    .read<RegisterProvider>()
                    .sendVerifitionCode(emailController.text, context),
                buttonTextStyle: style.buttonTextStyle),
            TextFormFieldWithButton(
              buttonTheme: style.buttonTheme,
              itemMargin: style.itemMargin,
              controller: verifyController,
              validator: context.read<RegisterProvider>().emailValidator,
              label: "Code",
              buttonOnPress: () => context.read<RegisterProvider>().verifyCode(
                  emailController.text, verifyController.text, context),
              margin: style.textMargin,
              buttonTextStyle: style.buttonTextStyle
            ),
            CustomTextFormField(
                validator: context.read<RegisterProvider>().defaultValidator,
                label: "Password",
                controller: passwordController,
                margin: style.textMargin,
                obscure: true,
                suggestion: false,
                autoCorrect: false,
                onChange: context.read<RegisterProvider>().passwordChange),
            CustomTextFormField(
              validator: context.read<RegisterProvider>().passwordValidator,
              label: "Confirm Password",
              controller: confirmController,
              margin: style.textMargin,
              obscure: true,
              suggestion: false,
              autoCorrect: false,
            ),
            CustomTextFormField(
              validator: context.read<RegisterProvider>().defaultValidator,
              label: "name",
              margin: style.textMargin,
              controller: nameController,
              obscure: false,
              suggestion: true,
              autoCorrect: true,
            ),
            CustomTextFormField(
                validator: context.read<RegisterProvider>().defaultValidator,
                label: "Nickname",
                margin: style.textMargin,
                controller: nickNameController,
                obscure: false,
                suggestion: true,
                autoCorrect: true),
            SubmitButton(
              buttonTheme: style.buttonTheme,
              label: "Register",
              width: style.buttonSize(context),
              margin: style.buttonMargin,
              onPress: () => context.read<RegisterProvider>().onButtonPress(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  nameController.text.trim(),
                  nickNameController.text.trim(),
                  rformKey,
                  context),
            )
          ],
        ));
  }
}
