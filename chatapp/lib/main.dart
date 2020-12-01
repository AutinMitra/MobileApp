import 'package:chatapp/theme/theme.dart';
import 'package:chatapp/views/chat_page.dart';
import 'package:chatapp/views/greeting_page.dart';
import 'package:chatapp/views/login_page.dart';
import 'package:chatapp/views/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();


    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("An error occurred."));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final FirebaseAuth auth = FirebaseAuth.instance;
          final bool signedIn = auth.currentUser != null;

          return MaterialApp(
            theme: Themes.lightMode,
            home: ChatPage(),
            initialRoute: signedIn ? '/' : '/greeting',
            routes: {
              '/greeting': (context) => GreetingPage(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
            },
          );
        }

        return Container();
      },
    );
  }
}