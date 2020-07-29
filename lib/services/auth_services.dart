import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

   Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //Sign Up
  Future<String> createUserWithEmailAndPassword(
    String email, String password, String name) async {
     final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
       email: email, 
       password: password,
      );
  
  
      //Update name
      await updateUserName(name, authResult.user);
      return authResult.user.uid;
    }
     
    
  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
   }

   // Email & Password login 
   Future<String> signInWithEmailAndPassword(String email,
    String password) async {
   return (await _firebaseAuth.signInWithEmailAndPassword(
    email: email, password: password)).user.uid;
   }
     
  //signout
   signOut() {
    return _firebaseAuth.signOut();
  }

  //Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
  
  //Anonymous User
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }
}

   class NameValidator {
     static String validate(String value) {
       if(value.isEmpty) {
         return "Name can't be empty";
       }
       if(value.length < 2) {
         return "Name must be at least 2 characters long";
       }
       if(value.length > 30) {
         return "Name must be les than 30 characters long";
       }
       return null;
     }
   }

      class EmailValidator {
     static String validate(String value) {
       if(value.isEmpty) {
         return "Email can't be empty";
       }
       return null;
     }
   }

      class PasswordValidator {
     static String validate(String value) {
       if(value.isEmpty) {
         return "Password can't be empty";
       }
       return null;
     }
   }