import 'package:chatapp/components/button.dart';
import 'package:chatapp/theme/fontstyles.dart';
import 'package:chatapp/theme/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void signOut() {
    auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/greeting', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;

    var topInset = MediaQuery.of(context).padding.top + 24;

    return Scaffold(
      backgroundColor: Palette.bg,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          children: [
            SizedBox(height: topInset),
            Text("Messages", style: pageTitle),
            SizedBox(height: 8),
            if (user != null)
              Text("Email: ${user.email}", style: pageTitleDescriptor,),
            SizedBox(height: 24,),
            CustomButton(
              child: Text("Logout", style: buttonText,),
              onTap: signOut,
            )
          ],
        ),
      ),
    );
  }
}