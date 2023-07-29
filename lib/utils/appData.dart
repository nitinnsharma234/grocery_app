

import 'package:grocery_app/screens/store_viewModel.dart';

import '../model/userModel.dart';
import '../screens/product_viewModel.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  AppData._internal();

  factory AppData(){
    return _appData;
  }
  User? user;
  List<Product> products=[];
  List<Store> stores=[];

}