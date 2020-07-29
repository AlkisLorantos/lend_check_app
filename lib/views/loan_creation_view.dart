import 'package:flutter/material.dart';

class LoanCreationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
              ),
            ),
            RaisedButton(
              child: Text("Create"),
              onPressed: () {
                
              } 
            ),
          ],
        ),
      ),
    );
  }
}