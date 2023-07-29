import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/userModel.dart';
import '../utils/appData.dart';


class Product {
  String productName;
  String imageUrl;
  List<CheapestPrice> cheapestPrice;
  num minPrice;
  num carbs;
  num protein;
  num sugar;
  num fats;
  num fiber;

  Product({
    required this.productName,
    required this.imageUrl,
    required this.cheapestPrice,
    required this.carbs,
    required this.protein,
    required this.sugar,
    required this.fats,
    required this.fiber,
  }): minPrice = _calculateMinPrice(cheapestPrice);
  static int _calculateMinPrice(List<CheapestPrice> cheapestPrice) {
    if (cheapestPrice.isEmpty) {
      return 0; // Return 0 if the list is empty
    } else {
      int minPrice = cheapestPrice[0].price;
      for (var priceObj in cheapestPrice) {
        if (priceObj.price < minPrice) {
          minPrice = priceObj.price;
        }
      }
      return minPrice;
    }
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productName: json["productName"],
    imageUrl: json["imageUrl"],
    carbs: json["carbs"],
    protein: json["protein"],
    fiber: json["fiber"],
    fats: json["fats"],
    sugar: json["sugar"],
    cheapestPrice: List<CheapestPrice>.from(json["cheapestPrice"].map((x) => CheapestPrice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "imageUrl": imageUrl,
    "cheapestPrice": List<dynamic>.from(cheapestPrice.map((x) => x.toJson())),
  };
}

class CheapestPrice {
  int price;
  String storeId;

  CheapestPrice({
    required this.price,
    required this.storeId,
  });

  factory CheapestPrice.fromJson(Map<String, dynamic> json) => CheapestPrice(
    price: json["price"],
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "storeId": storeId,
  };
}
class ProductViewModel extends ChangeNotifier {
  bool loading = false;
  List<Product> product = [];
  List<String> productIds = [];
  int filterCount=0;

  get allProducts
  {
    product= AppData().products;
    print("Getitng all products ${AppData().products}");
    notifyListeners();
  }

  fetchAllProducts() async {
    print("Fetching products");
    try {
      loading = true;
      QuerySnapshot<Map<String, dynamic>> response =
      await FirebaseFirestore
          .instance
          .collection("products")
          .get();

      print("My Response is${response.docs}");
      await Future.delayed(Duration(seconds: 4));
      var list = response.docs;
      List<Product> products = [];
      list.forEach((element) {
        Product p = Product.fromJson(element.data());
        products.add(p);
        //print("Catbs is ${element.data()["carbs"]}");
        productIds.add(element.id);
      });
      product = products.toList();
      AppData().products=product;
      loading = false;
      notifyListeners();
      print(productIds);
    } catch (err) {
      loading = false;
    }
  }

  void addPriceinProduct() async {
    var products = [
      "1lrDjSUrGkbMaWgjHrQk",
      "4Ymfhcoxab8gvcGOqz4E",
      "Av2smilg5NfZt8fV2ZMR",
      "EAUV6Y8L0884nFg07T51",
      "ESUM3muDJcw5sJOG9H5w",
      "Gp7ALpRehfH5VipnKS6D",
      "I2cB8Gv9Eu5rtjLEiBQV",
      "IXJ5ZV4Vt5lrSqJMdVwh",
      "M7n9EOyXx7Yuc9LWNCbw",
      "MvGMLZ5X6wKmNKNgSSLN",
      "Mzp0Ri3RnYjGhZXDnQVI",
      "OyFLDoXmJ3Q8qSkL27IG",
      "Rkp3je68IeAm8iwHabGX",
      "f1ecm5rq5eivpTI2560c",
      "jMbACxreHZCXLbCWMggJ",
      "k9tIRIZJreQEw17eGOda",
      "oguHxVscaOb71mrlgUfd",
      "qRguDHusNMQYZmf5wr28",
      "wcv6tOwuK2WFt4GuhfOs",
      "z7fdlBM9idqdbxBj5hxS"
    ];
    updateProductsWithRandomValues(products);
  }
  Future<void> updateProductsWithRandomValues(List<String> productIds) async {
    // Function to generate random values between 0 and 80 for each nutrient
    int getRandomValue() => Random().nextInt(81);

    // Loop through each product ID and update the corresponding document
    for (String productId in productIds) {
      // Generate random values for each nutrient
      int carbs = getRandomValue();
      int protein = getRandomValue();
      int fats = getRandomValue();
      int fiber = getRandomValue();
      int sugar = getRandomValue();

      // Construct a map containing the updated nutrient values
      Map<String, dynamic> fieldsToRemove = {
        "carbs": carbs,
        "protein": protein,
        "fats": fats,
        "fiber": fiber,
        "sugar": sugar,
      };


      // Update the document in Firestore
      try {
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productId)
            .update(fieldsToRemove);
        print("Product with ID $productId updated successfully.");
      } catch (e) {
        print("Error updating product with ID $productId: $e");
      }
    }
  }

  Future<void>filterBy(
      {bool? protein=false, bool? carbs=false, bool? fiber=false, bool? fats=false, bool? sugar=false})async {
    var user=AppData().user as User;
    int? maxProtein=user.protein;
    int? maxCarbs=user.carbs;
    int? maxFiber=user.fiber;
    int? maxFats=user.fats;
    int? maxSugar=user.sugar;
    print("Pr${maxProtein} ${maxCarbs} ${maxFiber} ${maxSugar} ${maxFats}");
    var abc= allProducts;
     abc=product.where((element)  {

      if(protein! &&maxProtein!=null && element.protein>maxProtein){
        return false;
      }
      if(fats! &&maxFats!=null && element.fats>maxFats){
        return false;
      } if(carbs! &&maxCarbs!=null && element.carbs>maxCarbs){
        return false;
      } if(fiber! &&maxFiber!=null && element.fiber>maxFiber){
        return false;
      } if(sugar! &&maxSugar!=null && element.sugar>maxSugar){
        return false;
      }
      return true;
    }).toList();
    print("List size is ${abc.length}");
   this.product=abc;
   notifyListeners();
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



