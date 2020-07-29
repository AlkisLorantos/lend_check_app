// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:loaned_money_tracker/Animations/fade_animation.dart';
// import 'package:loaned_money_tracker/services/auth_services.dart';
// import 'package:loaned_money_tracker/provider.dart';
// import 'package:loaned_money_tracker/views/Auth/sign_up_view.dart';


// class LoginView extends StatefulWidget {
//   @override
//   _LoginViewState createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String _email, _password, _error;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         brightness: Brightness.light,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
//         ),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       FadeAnimation(1, Text("Login", style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold
//                       ),)),
//                       SizedBox(height: 20,),
//                       FadeAnimation(1.2, Text("Login to your account", style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.grey[700]
//                       ),)),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: Column(
//                       children: <Widget>[
//                         FadeAnimation(
//                           1.2, emailTextField(
//                             label: "Email"
//                           )
//                         ),
//                         FadeAnimation(
//                           1.3, passwordTextField(
//                           label: "Password", 
//                           obscureText: true)
//                         ),
//                       ],
//                     ),
//                   ),
//                   FadeAnimation(1.4, Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: Container(
//                       padding: EdgeInsets.only(top: 3, left: 3),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border(
//                           bottom: BorderSide(color: Colors.black),
//                           top: BorderSide(color: Colors.black),
//                           left: BorderSide(color: Colors.black),
//                           right: BorderSide(color: Colors.black),
//                         )
//                       ),
//                       child: MaterialButton(
//                         minWidth: double.infinity,
//                         height: 60,
//                         onPressed: () {},
//                         color: Colors.greenAccent,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)
//                         ),
//                         child: Text("Login", style: TextStyle(
//                           fontWeight: FontWeight.w600, 
//                           fontSize: 18
//                         ),),
//                       ),
//                     ),
//                   )),
//                   FadeAnimation(1.5, Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text("Don't have an account?"),
//                       Text(" Sign up", style: TextStyle(
//                       ),),
//                     ],
//                   ))
//                 ],
//               ),
//             ),
//             FadeAnimation(1.2, Container(
//               height: MediaQuery.of(context).size.height / 3,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/background.png'),
//                   fit: BoxFit.cover
//                 )
//               ),
//             ))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget emailTextField({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(label, style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//           color: Colors.black87
//         ),),
//         SizedBox(height: 5,),
//         TextFormField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[400])
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[400])
//             ),
//           ),
//           onSaved: (value) => _email = value,
//         ),
//         SizedBox(height: 30,),
//       ],
//     );
//   }

// Widget passwordTextField({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(label, style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//           color: Colors.black87
//         ),),
//         SizedBox(height: 5,),
//         TextFormField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[400])
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[400])
//             ),
//           ),
//           onSaved: (value) => _password = value,
//         ),
//         SizedBox(height: 30,),
//       ],
//     );
//   }

 
//  Future<void> signIn() async { 
//    final formState = _formKey.currentState;
//    if(formState.login()) {
//      formState.save();
//      try {
//        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//         Navigator.of(context).pushReplacementNamed('/home');
//        //TODO: Naviagte to home
//       }catch (e) {
//        print(e.message);
//       }

//     }
//   }
// }




  
//   // Widget showError() {
//   //   if(_error != null) {
//   //     return Container(
//   //       color: Colors.white,
//   //       width: double.infinity,
//   //       padding: EdgeInsets.all(8.0),
//   //       child: Row(
//   //         children: <Widget>[
//   //           Padding(
//   //             padding: const EdgeInsets.only(right: 8.0),
//   //             child: Icon(Icons.error_outline),
//   //           ),
//   //           Expanded(child: AutoSizeText(_error, maxLines: 3,),),
//   //           Padding(
//   //             padding: const EdgeInsets.only(left: 8.0),
//   //             child: IconButton(
//   //               icon: Icon(Icons.close),
//   //               onPressed: () {
//   //                 setState(() {
//   //                   _error = null;
//   //                 });
//   //               }
//   //             ),
//   //           )
//   //         ],
//   //       ),
//   //     );
//   //   }
//   //   return SizedBox(height: 0,);
//   // }

// // showForgotPassword(_showForgotPassword), 
// //      FlatButton(
// //        child: Text(
// //          _switchButtonText, 
// //          style: TextStyle(color: Colors.grey),),
// //        onPressed: () {
// //           switchFormState(_newFormState);
// //        },
// //      )
// //     ];


  
// //   Widget showForgotPassword(bool visible) {
// //     return Visibility(
// //       child: FlatButton(
// //         child: Text(
// //           "Forgot Password?",
// //           style: TextStyle(color: Colors.grey),
// //         ),
// //         onPressed: () {
// //           setState(() {
// //             authFormStatus = AuthFormStatus.reset;
// //           });
// //         }
// //       ),
// //       visible: visible,
// //     );
// //   }
// // }

