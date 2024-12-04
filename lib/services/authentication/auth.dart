import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<UserCredential>  logInWithEmailAndPassword(
      {required String email, required String password})  {
    return  _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
  }

 Future<UserCredential>  signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
  }

  Future<void> resetPassword({required String email}) async{
    
    try {
      
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
    
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
