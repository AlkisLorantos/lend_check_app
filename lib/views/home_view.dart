import 'package:flutter/material.dart';
import 'package:loaned_money_tracker/services/auth_services.dart';
import 'package:loaned_money_tracker/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.2,
              color: Colors.grey.withOpacity(0.2),
            )
          ],
        )
      )
    );
  }
}


AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.menu),
      color: Colors.grey,
      onPressed: () {},
    ),
    title: RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Loaned Money",
            style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
            text: " Tracker",
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.account_circle),
        color: Colors.grey,
        onPressed: () async {
         try {
           AuthService auth = Provider.of(context).auth;
            await auth.signOut();
             print("Signed Out!");
          } catch (e) {
             print (e);
         }
       },
      ),
    ],
  );
}