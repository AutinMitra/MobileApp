import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/theme/fontstyles.dart';
import 'package:chatapp/theme/palette.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _authError = "";

  void goToChat() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (e) => false);
  }

  void submit() async {
    setState(() {
      _authError = "";
    });

    if (_formKey.currentState.validate()) {
      var email = _emailController.text;
      var password = _passwordController.text;
      var res = await login(email: email, password: password, onSuccess: goToChat);
      setState(() {
        _authError = res;
      });
    }
  }

  String validateInput(String e) {
    return e.isEmpty ? "Please fill out this field." : null;
  }

  String validateEmail(String e) {
    if (e.isEmpty)
      return "Please fill out this field.";

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    if (!emailValid)
      return "Invalid Email.";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Palette.bg.withOpacity(0.7),
    );
    var topInset = MediaQuery.of(context).padding.top + appBar.preferredSize.height;

    return Scaffold(
      backgroundColor: Palette.bg,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
            children: [
              SizedBox(height: topInset),
              Text("Log In.", style: pageTitle),
              SizedBox(height: 12),
              Text(
                "Sign in with your information from registration.",
                style: pageTitleDescriptor,
              ),
              SizedBox(height: 12),
              CustomTextField(
                controller: _emailController,
                validator: validateEmail,
                labelText: "Email",
                hintText: "johndoe@mail.com",
              ),
              SizedBox(height: 12),
              CustomTextField(
                controller: _passwordController,
                validator: validateInput,
                labelText: "Password",
                hintText: "At least 8 Characters",
                obscureText: true,
              ),
              SizedBox(height: 24),
              CustomButton(
                child: Text("Log In", style: buttonText),
                onTap: submit,
              ),
              SizedBox(height: 12),
              if (_authError.isNotEmpty)
                Center(child: Text(_authError, style: errorText,))
            ],
          ),
        ),
      ),
    );
  }
}