import 'package:flutter/material.dart';
import 'package:loaned_money_tracker/services/auth_services.dart';
import 'package:loaned_money_tracker/views/Auth/login_view.dart';
import 'package:loaned_money_tracker/views/home_view.dart';
import 'package:loaned_money_tracker/views/Auth/welcome_view.dart';
import 'package:loaned_money_tracker/provider.dart';
import 'package:loaned_money_tracker/views/Auth/auth_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
       child: MaterialApp(
        title: "Loaned Money Tracker",
        theme: ThemeData(
          primarySwatch : Colors.green
        ),
        home:HomeController(),
        routes: <String, WidgetBuilder> {
          '/home' : (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) =>  SignUpView(authFormStatus: AuthFormStatus.signUp),
          '/login' : (BuildContext context) => SignUpView(authFormStatus: AuthFormStatus.login,),
          '/anonymousSignIn' : (BuildContext context) => SignUpView(authFormStatus: AuthFormStatus.anonymous),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? HomeView() : WelcomeView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}