import 'package:flutter/material.dart';
import 'package:loaned_money_tracker/services/auth_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:loaned_money_tracker/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loaned_money_tracker/Animations/fade_animation.dart';

enum AuthFormStatus {login, signUp, anonymous, reset}

class SignUpView extends StatefulWidget {
  final AuthFormStatus authFormStatus;

  SignUpView({Key key, @required this.authFormStatus}) : super (key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormStatus: this.authFormStatus);
}

class _SignUpViewState extends State<SignUpView> {

    AuthFormStatus authFormStatus;  
    _SignUpViewState({this.authFormStatus});
   
   final formKey = GlobalKey<FormState>();
   
    String _email, _password, _name, _error;



    void switchFormState(String state) {
      formKey.currentState.reset();
      if(state == "signUp") {
        setState(() {
          authFormStatus = AuthFormStatus.signUp;
        });
      } else {
        setState(() {
          authFormStatus = AuthFormStatus.login;
        });
      }
    }
      
    bool validate() {
      final form = formKey.currentState;
      form.save();
      if (form.validate()) {
        form.save();
        return true;
      } else {
        return false;
      }
    }
    
    void submit() async {
    if (validate()) {
      try {
         final auth = Provider.of(context).auth;
      if(authFormStatus == AuthFormStatus.login) {
         String uid = await auth.signInWithEmailAndPassword(_email, _password);
         print("Signed In with ID $uid");
         Navigator.of(context).pushReplacementNamed('/home');
      }  else if (authFormStatus == AuthFormStatus.reset) {
        await auth.sendPasswordResetEmail(_email);
         print("Password reset email sent");
         _error = "A password reset link has been sent to $_email";
         setState(() {
           authFormStatus = AuthFormStatus.login;
         });
      }  else {
         String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
         print("Signed up with  New ID $uid");
         Navigator.of(context).pushReplacementNamed('/home');
        }
      }catch (e) {
       setState(() {
         _error = e.message;
       });
      }
    } 
  }

  Future submitAnonymously() async {
    final auth = Provider.of(context).auth;
    await auth.signInAnonymously();
    Navigator.of(context).pushReplacementNamed('/home');
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormStatus == AuthFormStatus.anonymous) {
      submitAnonymously();
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitCircle(color: Colors.grey),
            Text("Loading", style: TextStyle(color: Colors.black),),
          ],
        )
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.025),
              showError(),
              SizedBox(height: _height * 0.025),
              builHeaderText(),
              SizedBox(height: _height * 0.025),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showError() {
    if(_error != null) {
      return Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_error, maxLines: 3,),),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                }
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0,);
  }
  
  AutoSizeText builHeaderText() {
    String _headerText;
    if(authFormStatus == AuthFormStatus.signUp) {
      _headerText = "Create New Account";
    } else if (authFormStatus == AuthFormStatus.reset) {
       _headerText = "Reset Password";
    } else {
      _headerText = "Login";
    }

    return AutoSizeText(
      _headerText,
      maxLines: 2,
      style: TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }




  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if(authFormStatus == AuthFormStatus.reset) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 18.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
      return textFields;
    }
     
    // Name Text Field for Sign Up View
    if(authFormStatus == AuthFormStatus.signUp) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 18.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }

   textFields.add(
    TextFormField(
      validator: EmailValidator.validate,
      style: TextStyle(fontSize: 18.0),
      decoration: buildSignUpInputDecoration("Email"),
      onSaved: (value) => _email = value,
    ),
   );
   
     textFields.add(SizedBox(height: 20));
     textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 18.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20));

   return textFields;
  
  }
   
   InputDecoration buildSignUpInputDecoration(String label) {
     return InputDecoration(
       icon: Icon(Icons.person),
       labelText: label,
       labelStyle: TextStyle(
         color: Colors.grey
       )
     ); 
    }

 List<Widget> buildButtons() {
   String _switchButtonText, _newFormState, _submitButtonText;
   bool _showForgotPassword = false;

    if (authFormStatus == AuthFormStatus.login) {
     _switchButtonText = "Create New Account";
     _newFormState = "signUp";
     _submitButtonText = "Login";
     _showForgotPassword = true;
   } else if (authFormStatus == AuthFormStatus.reset) {
      _switchButtonText = "Return to Login";
     _newFormState = "login";
     _submitButtonText = "Submit";
   } else { 
    _switchButtonText = "Already have an account? Login";
     _newFormState = "Login";
     _submitButtonText = "Sign Up";

   }

   return [
     //Submit button
     Container(
       width: MediaQuery.of(context).size.width * 0.8,
       child: MaterialButton(
         minWidth: double.infinity,
         height: 50.0,
         elevation: 0,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50)),
         color: Colors.blue[800],
         textColor: Colors.white,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text (_submitButtonText, 
           style: TextStyle(
             fontSize: 18.0, fontWeight: FontWeight.w600
             ),
            ),
          ),
          onPressed: submit,
        ),
     ),



     showForgotPassword(_showForgotPassword), 
     FlatButton(
       child: Text(
         _switchButtonText, 
         style: TextStyle(color: Colors.grey),),
       onPressed: () {
          switchFormState(_newFormState);
       },
     )
    ];

  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.grey),
        ),
        onPressed: () {
          setState(() {
            authFormStatus = AuthFormStatus.reset;
          });
        }
      ),
      visible: visible,
    );
  }
}
