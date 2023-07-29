import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/components/grocery_item_tile.dart';
import 'package:grocery_app/screens/edit_pref_screen.dart';
import 'package:grocery_app/screens/product_viewModel.dart';
import 'package:grocery_app/screens/stores_screen.dart';
import 'package:grocery_app/utils/textStyles.dart';
import 'package:provider/provider.dart';

import '../login_flow/registration_screen.dart';
import '../model/FilterModel.dart';
import '../model/userModel.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({this.user, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductViewModel _viewModel = ProductViewModel();
  final _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _viewModel.fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Products",
              style: whiteH1Medium,
            ),
            backgroundColor: Colors.pinkAccent[100]),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(
                          "Cheapest Products Among all stores",
                          style: whiteH4Medium.copyWith(color: Colors.black,),
                             textAlign: TextAlign.center,
                        ),),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.grey.shade50,
                              context: context,
                              builder: (context) {
                                return CheckBoxWidget(
                                  callback:
                                      (protein, sugar, fat, fiber, carbs) {
                                    int count = 0;
                                    protein ? count++ : count;
                                    sugar ? count++ : count;
                                    fat ? count++ : count;
                                    fiber ? count++ : count;
                                    carbs ? count++ : count;
                                    _viewModel.filterCount = count;
                                    _viewModel.filterBy(
                                        protein: protein,
                                        sugar: sugar,
                                        fats: fat,
                                        fiber: fiber,
                                        carbs: carbs);
                                  },
                                );
                              },
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                              ),
                            );
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/filter.svg",
                            color: Colors.white,
                            fit: BoxFit.scaleDown,
                            height: 24,
                            width: 24,
                          ),
                          label: Consumer<ProductViewModel>(
                              builder: (context, value, child) {
                            return Text("Filter (${_viewModel.filterCount})");
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent.shade100)),
                    ),
                    Consumer<ProductViewModel>(
                      builder: (context, value, child) {
                        if (value.product.isNotEmpty) {
                          print(value.product.length);
                          return GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(12),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.product.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.2,
                            ),
                            itemBuilder: (context, index) {
                              return GroceryItemTile(
                                  itemName: value.product[index].productName,
                                  itemPrice:
                                      value.product[index].minPrice.toString(),
                                  imagePath: value.product[index].imageUrl,
                                  color: Colors.grey,
                                  onPressed: () => {});
                            },
                          );
                        }
                        return const Center(child: Text("No items found"));
                      },
                    ),
                  ],
                ),
                Consumer<ProductViewModel>(builder: (context, value, child) {
                  if (_viewModel.loading) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator(color: Colors.pinkAccent ,)));
                  }
                  return Container();
                })
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const StoreScreen();
                  },
                ),
              );
            },
            backgroundColor: Colors.pinkAccent[100],
            child: const Icon(
              Icons.storefront,
            )),
        drawer: Drawer(
          elevation: 20,
          child: Column(
            children: [
              PreferredSize(
                  preferredSize: AppBar().preferredSize,
                  child: Container(
                    color: Colors.pinkAccent[100],
                    height: AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "${widget?.user?.firstName} ${widget?.user?.lastName}",
                            style: whiteH1Bold.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Image.network(
                          "https://img.icons8.com/?size=512&id=Ry7mumEprV9w&format=png",
                          height: 64,
                          width: 64,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 10,),
              ListTile(leading: const Icon(Icons.edit),title: const Text('Edit Preferences'),onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context,EditPrefScreen.route);
              },),
              Container(width: double.infinity,height: 1,color: Colors.grey,),
              const SizedBox(height: 10,),
              ListTile(leading: const Icon(Icons.shop),title: const Text('Favourite Stores'),onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const StoreScreen(favourite: true,);
                    },
                  ),
                );

              },),
              Container(width: double.infinity,height: 1,color: Colors.grey,),

              const Spacer(),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      fb.FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                          RegistrationScreen.route,
                              (Route<dynamic> route) =>
                          false);
                    },
                    icon: Icon(Icons.logout),
                    label: const Text("Log Out"),style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent[100]),),
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customCheckBox(bool val, Function(bool) onChange, String tittle) {
  return CheckboxListTile(
    value: val,
    onChanged: (val) {
      onChange(val!);
    },
    activeColor: Colors.pinkAccent[100],
    title: Text(
      tittle,
      style: whiteH4Medium.copyWith(color: Colors.black),
    ),
  );
}

class CheckBoxWidget extends StatefulWidget {
  final Function(bool, bool, bool, bool, bool) callback;

  const CheckBoxWidget({required this.callback, Key? key}) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  Filter filter = Filter();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            children: [
              Text(
                "Apply Filters",
                style: whiteH1Bold.copyWith(color: Colors.black),
              ),
              customCheckBox(filter.protein, (val) {
                setState(() {
                  filter.protein = val;
                });
              }, "Protein"),
              customCheckBox(filter.sugar, (val) {
                setState(() {
                  filter.sugar = val;
                });
              }, "Sugars"),
              customCheckBox(filter.fats, (val) {
                setState(() {
                  filter.fats = val;
                });
              }, "Fats"),
              customCheckBox(filter.fiber, (val) {
                setState(() {
                  filter.fiber = val;
                });
              }, "Fibers"),
              customCheckBox(filter.carbs, (val) {
                setState(() {
                  filter.carbs = val;
                });
              }, "Carbohydrates"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 56),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          filter.resetFilter();
                          widget.callback(filter.protein, filter.sugar,
                              filter.fats, filter.fiber, filter.carbs);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Reset Filters",
                        style: whiteH4Medium.copyWith(
                            color: Colors.pinkAccent[100]),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.callback(filter.protein, filter.sugar,
                            filter.fats, filter.fiber, filter.carbs);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent[100]),
                      child: Text("Apply Filters"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
