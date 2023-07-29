import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:grocery_app/components/StoreTiles.dart';
import 'package:grocery_app/components/grocery_item_tile.dart';
import 'package:grocery_app/screens/map_screens.dart';
import 'package:grocery_app/screens/store_viewModel.dart';
import 'package:grocery_app/utils/textStyles.dart';
import 'package:provider/provider.dart';

import '../login_flow/profile_completion.dart';
import '../model/userModel.dart';

class StoreScreen extends StatefulWidget {
  final User? user;
  final bool? favourite;

  const StoreScreen({this.user, this.favourite=false,Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final StoreViewModel _viewModel = StoreViewModel();
  bool favouriteScreen=false;
  @override
  void initState() {
    // TODO: implement initState
    favouriteScreen=widget.favourite!;
    _viewModel.fetchAllStores();
    if(favouriteScreen) {
      print("Favourite Stores");
      _viewModel.favouriteStore();
    }
    print("Yes");
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              !favouriteScreen?"Stores":"Favourite Stores",
              style: whiteH1Medium,
            ),
            backgroundColor: Colors.pinkAccent[100]),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        style: whiteH3Medium.copyWith(color: Colors.black),
                        "Stores Here",
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Consumer<StoreViewModel>(
                        builder: (context, value, child) {
                          List<Store> list=_viewModel.storees;
                        if(favouriteScreen)
                          {
                            list =list.where((element) => element.isFavourite).toList();
                          }
                          if (list.isNotEmpty) {
                            return GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(12),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.2,
                              ),
                              itemBuilder: (context, index) {
                                return Consumer<StoreViewModel>(
                                  builder: (context, _viewModel, child) {
                                    return StoreTiles(
                                      itemName:list[index].name,
                                      isFavourite:
                                          list[index].isFavourite,
                                      imagePath:
                                          "https://img.icons8.com/?size=512&id=bfUmjY7hhAuY&format=png",
                                      color: Colors.grey,
                                      onPressed: ()  {
                                        _viewModel.addFavourite(list[index].id!, !list[index].isFavourite, () => {
                                        list[index].isFavourite = !value.storees[index].isFavourite,
                                        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                                        "Something went wrong!"))
                                        },favScreen: favouriteScreen);
                                        list[index].isFavourite = !list[index].isFavourite;
                                      },
                                      onTapped:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const StoreMapScreen();
                                            },
                                          ),
                                        );
                                      }
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return const Center(child: Text("No items found"));
                        },
                      ),
                    ],
                  ),
                ),
                Consumer<StoreViewModel>(builder: (context, value, child) {
                  if (_viewModel.loading) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator(color: Colors.pinkAccent,)));
                  }
                  return const Center();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
