import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/network_service/service/ApiResponse.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<ApiResponse?> login({
    required String email,
    required String password,
  }) async {
    try {
     UserCredential data= await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ApiResponse.completed(data);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ApiResponse.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ApiResponse.error('Wrong password provided for that user.');
      } else {
        return ApiResponse.error(e.message);
      }
    } catch (e) {
      return ApiResponse.error( e.toString());
    }
  }
}
enum Response{
  Sucess,
  Loading,
  Error
}