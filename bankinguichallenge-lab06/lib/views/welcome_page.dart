import 'package:bankinguichallenge/components/buttons.dart';
import 'package:bankinguichallenge/services/banking_file_utils.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void goToDribbble() async {
    const url = 'https://dribbble.com/shots/14364583-Online-Banking-Mobile-App';
    if (await canLaunch(url))
      await launch(url);
  }

  void exitWelcome() {
    var firstRunKey = BankingStorageUtils.firstRunPrefs;
    BankingStorageUtils.prefs.setBool(firstRunKey, false);
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Palette.bg,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: _welcomeText(),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _bottomButtonBar(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeText() {
    var subTitleText = "Just a credit card debt simulator™. "
        "Written with code organization in mind and over-engineered state management (BLoC). "
        "Why? Because why not! "
        "Enjoy the fancy UI!";
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Welcome!", style: pageTitle),
        Text(subTitleText, style: subText),
      ],
    );
  }

  Widget _bottomButtonBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomRaisedButton(
          child: Text("Check Out UI Inspiration", style: buttonText),
          onTap: goToDribbble,
        ),
        SizedBox(height: 14,),
        CustomRaisedButton(
          color: Palette.red,
          onTap: exitWelcome,
          child: Text("Let's Go!", style: buttonText),
        ),
      ],
    );
  }
}