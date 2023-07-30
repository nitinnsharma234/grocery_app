import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/utils/appData.dart';


class Store {
  String name;
  String? id;
  num ?lat;
  num? long;
  bool isFavourite=false;


  Store({
    required this.name,
      this.id,
    required this.isFavourite,
     this.lat,
     this.long,

  });


  factory Store.fromJson(Map<String, dynamic> json,id) => Store(
    name: json["name"], isFavourite:json["isFavourite"] ?? false,id: id,
      long: json["long"],lat: json["lat"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isFavourite":isFavourite
  };
}


class StoreViewModel extends ChangeNotifier {
  bool loading = false;
  List<Store> storees = [];
  List<Store> favStores = [];

  void fetchAllStores() async {

    try {
      loading = true;
      QuerySnapshot<Map<String, dynamic>> response =
      await FirebaseFirestore.instance.collection("stores").get();
      await Future.delayed(const Duration(seconds: 2));
      var list = response.docs;
      List<Store> stores = [];
      for (var element in list) {
        Store p = Store.fromJson(element.data(),element.id);
        stores.add(p);
      }
      AppData().stores=stores;
      print("Completed AppData");
      storees = stores.toList();
      loading = false;
      notifyListeners();
    } catch (err) {
      loading = false;
    }
  }
  void favouriteStore(){
    List<Store> store=AppData().stores.where((element)=>element.isFavourite).toList();
    print("Completed fav");
    favStores=store;
    notifyListeners();
  }

  void addFavourite(String storeId,bool val,Function()callback,{bool? favScreen=false})async{
    loading=true;
    notifyListeners();
    try{
      await FirebaseFirestore.instance
          .collection("stores")
          .doc(storeId).update({"isFavourite":val});
      if(favScreen!)
        {
          storees.removeWhere((element) => element.id==storeId);
          loading=false;
          notifyListeners();
        }
      loading=false;
      notifyListeners();
    }
    catch(err){
      print(err);
      callback();
      notifyListeners();
      rethrow;
    }
    print("Done SucessFully");
  }
}
class Price {
  int price;
  String storeId;

  Price({required this.price, required this.storeId});
  Map<String, dynamic> toMap() {
    return {
      "price": price,
      "storeId": storeId,
    };
  }
}