import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/cupertino.dart';
import '../model/userModel.dart';
import '../network_service/service/ApiResponse.dart';
import '../utils/appData.dart';

class LoginViewModel extends ChangeNotifier {
  bool loading = false;
  late User user ;
  ApiResponse response = ApiResponse.initial("");

  Future<ApiResponse?> registration({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    loading=true;
    notifyListeners();
    try {
      fb.UserCredential data =
          await fb.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
          );
      data?.user?.updateDisplayName("$firstName $lastName");
      await uploadingData(data?.user?.email, firstName, lastName, data.user?.uid);
      loading=false;
      notifyListeners();
      return ApiResponse.completed(data);
    } on fb.FirebaseAuthException catch (e) {
      loading=false;
      notifyListeners();
      if (e.code == 'weak-password') {
        ApiResponse.error('The password provided is too weak.');
        rethrow;
      } else if (e.code == 'email-already-in-use') {
        ApiResponse.error('The account already exists for that email.');
        rethrow;
      } else if (e.code == 'invalid-email') {
        ApiResponse.error('Enter a valid email');
        rethrow;
      } else {
        ApiResponse.error(e.code);
        throw (e.code);
      }
    } catch (e) {
      loading=false;
      notifyListeners();
      print("Error$e");
      ApiResponse.error(e.toString());
      rethrow;
    }
  }

  Future<ApiResponse?> login({
    required String email,
    required String password,
  }) async {
    loading = true;
    notifyListeners();
    try {
      fb.UserCredential data =
          await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loading = false;
     String? uid=data?.user?.uid;

     return getUserInfo(uid);
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loading = false;
        response = ApiResponse.error('No user found for that email.');
        rethrow;
      } else if (e.code == 'wrong-password') {
        loading = false;
        notifyListeners();
        response = ApiResponse.error('Wrong password provided for that user.');
        rethrow;
      } else {
        loading = false;
        notifyListeners();
        response = ApiResponse.error(e.message);
        rethrow;
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      ApiResponse.error(e.toString());
      rethrow;
    }
  }

  Future<void> uploadingData(
      String? email, String fName, String lName, String? uuid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .set({'firstName': fName, 'lastName': lName, 'email': email});
    } catch (err) {
      print(err.toString());
    }
  }

  Future<ApiResponse<User>> getUserInfo(String? uid) async {
    try{
      var resp = await FirebaseFirestore.instance
          .collection("users").doc(uid).get();
      print("${resp.data()}");
      user = User.fromJson(resp.data()!,resp.id);
      AppData().user=user;
      notifyListeners();
      response = ApiResponse.completed(user);
      return ApiResponse.completed(user);
    }
    catch(err){
      rethrow;
    }
  }
}
