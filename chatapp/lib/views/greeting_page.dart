import 'package:chatapp/components/button.dart';
import 'package:chatapp/theme/fontstyles.dart';
import 'package:flutter/material.dart';

class GreetingPage extends StatefulWidget {
  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  void goToLogin() {
    Navigator.of(context).pushNamed("/login");
  }

  void goToRegister() {
    Navigator.of(context).pushNamed("/register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Stack(
            children: [
              welcomeHeader(),
              authButtonbar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeHeader() {
    double imageWidth = MediaQuery.of(context).size.width - 48;
    double imageHeight = imageWidth/1600 * 1200-20;

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome.", style: pageTitle),
          SizedBox(height: 12),
          Text(
            "Try another random chat app, made with Flutter & Firebase.",
            style: pageTitleDescriptor,
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: new DecorationImage(
                image: new AssetImage("assets/graphics/collaboration.png"),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget authButtonbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomOutlineButton(
            onTap: goToLogin,
            child: Text("Login", style: buttonText),
          ),
          SizedBox(height: 14),
          CustomButton(
            onTap: goToRegister,
            child: Text("Register", style: buttonText),
          ),
        ],
      ),
    );
  }
}