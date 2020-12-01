import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/theme/fontstyles.dart';
import 'package:chatapp/theme/palette.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController = TextEditingController();

  String _authError = "";

  void goToChat() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (e) => false);
  }

  void submit() async {
    setState(() {
      _authError = "";
    });

    if (_formKey.currentState.validate()) {
      var firstName = _firstNameController.text;
      var lastName = _lastNameController.text;
      var email = _emailController.text;
      var password = _passwordController.text;
      var res = await register(firstName: firstName, lastName: lastName, email: email, password: password, onSuccess: goToChat,);
      setState(() {
        _authError = res;
      });
    }
  }

  String validateInputDefault(String s) {
    return s.isEmpty ? "Please fill out this field." : null;
  }

  String validateEmail(String e) {
    if (e.isEmpty)
      return "Please fill out this field.";

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    if (!emailValid)
      return "Invalid Email.";
    return null;
  }
  
  String validatePassword(String s) {
    // TODO: Adjust firebase security rules
    RegExp passwordExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passwordExp.hasMatch(s))
      return "Must be 8 characters, one special, one upper/lower";
    if (s != _passwordConfirmationController.text)
      return "Passwords do not match.";
    return null;
  }

  String validatePasswordConfirmation(String s) {
    if (s.isEmpty)
      return "Please fill out this field";
    if (s != _passwordController.text)
      return "Passwords do not match.";
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
              Text("Register.", style: pageTitle),
              SizedBox(height: 12),
              Text(
                "Input your information for registration.",
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
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      controller: _firstNameController,
                      validator: validateInputDefault,
                      labelText: "First Name",
                      hintText: "John",
                    ),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: CustomTextField(
                      controller: _lastNameController,
                      validator: validateInputDefault,
                      labelText: "Last Name",
                      hintText: "Doe",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              CustomTextField(
                controller: _passwordController,
                validator: validatePassword,
                labelText: "Password",
                hintText: "At least 8 Characters",
                obscureText: true,
              ),
              SizedBox(height: 12),
              CustomTextField(
                controller: _passwordConfirmationController,
                validator: validatePasswordConfirmation,
                labelText: "Confirm Password",
                hintText: "Re-type password",
                obscureText: true,
              ),
              SizedBox(height: 24),
              CustomButton(
                child: Text("Register", style: buttonText),
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