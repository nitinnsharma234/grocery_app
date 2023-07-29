import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/userModel.dart';


class ProfileViewModel extends ChangeNotifier {
  bool loading = false;
  late User user;

  Future<void> setUpYourProfile(String? uid, int protein, int carbs, int fiber,
      int sugar, int fats) async {
    try {
      var userProfile = UserProfile(protein: protein,
          carbs: carbs,
          fats: fats,
          sugar: sugar,
          fiber: fiber);
      loading = true;
      notifyListeners();

      var resp = await FirebaseFirestore.instance
          .collection("users").doc(uid).update(userProfile.toJson()).then((
          val) async {
        loading = false;
        notifyListeners();
        var response = await FirebaseFirestore.instance
            .collection("users").doc(uid).get();
        print("${response.data()}");
        user=User.fromJson(response.data()!,response.id);
      }
      );
    }
    catch(err)
    {
      rethrow;
    }
  }

}