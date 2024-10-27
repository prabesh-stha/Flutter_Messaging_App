import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/app_user.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<AppUser?> signIn(String email, String password) async{
    try{
      final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){
        return AppUser(uid: credential.user!.uid, email: credential.user!.email!);
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  static Future<AppUser?> signUp(String email, String password) async {
    try{
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if(credential.user != null){
        return AppUser(uid: credential.user!.uid, email: credential.user!.email!);
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  static Future<void> signOut() async{
    await _auth.signOut();
  }

  static Future<void> delete(String password) async{
    final user = _auth.currentUser;
    if (user != null){
      try{
        final credential = EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);
      await user.delete();
      await _auth.signOut();
      }catch(e){
        print("Error while deleting the user: $e");
      }
    }
    
  }
}