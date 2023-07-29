import 'package:flutter/material.dart';
import 'package:grocery_app/login_flow/profile_viewModel.dart';
import 'package:grocery_app/utils/appData.dart';
import 'package:provider/provider.dart';
import '../login_flow/profile_completion.dart';
import '../model/userModel.dart';
import '../utils/colors.dart';
import '../utils/textStyles.dart';
import '../utils/utils.dart';

class EditPrefScreen extends StatefulWidget {
  static String route="/edit-prefs";
  const EditPrefScreen({Key? key}) : super(key: key);


  @override
  State<EditPrefScreen> createState() => _EditPrefScreenState();
}

class _EditPrefScreenState extends State<EditPrefScreen> {
  TextEditingController proteinController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController fiberController = TextEditingController();
 final  ProfileViewModel _viewModel=ProfileViewModel();


 @override
  void initState() {
    // TODO: implement initState
   User?  appUser =AppData().user ;
   late User user;
   if(appUser!=null){
     user=appUser;
     proteinController.text=user.protein.toString();
     fatsController.text=user.fats.toString();
     fiberController.text=user.fiber.toString();
     sugarController.text=user.sugar.toString();
     carbsController.text=user.carbs.toString();
   }

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    proteinController.dispose();
    carbsController.dispose();
    sugarController.dispose();
    fatsController.dispose();
    fiberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<ProfileViewModel>(
        create: (BuildContext context) => _viewModel,
    child: Scaffold(
      appBar: AppBar(
          title: Text(
            "Edit Preferences",
            style: whiteH1Medium,
          ),
          backgroundColor: Colors.pinkAccent[100]),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Text(
                  "You can filter food items basis on the right amount set for you!",
                  textAlign: TextAlign.center,
                  style: whiteSubtitle.copyWith(color: grey1),
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: customNutritionalInfo(
                    proteinController, "weightscale.svg", "Protein",
                    context),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                child: customNutritionalInfo(
                    carbsController, "weightscale.svg", "Carbs", context),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                child: customNutritionalInfo(
                    sugarController, "weightscale.svg", "Sugar", context),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                child: customNutritionalInfo(
                    fatsController, "weightscale.svg", "Fats", context),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: customNutritionalInfo(
                    fiberController, "weightscale.svg", "Fiber", context),
              ),
              const SizedBox(
                height: 40,
              ),
              const Spacer(),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child:

                shadeButton("Save", () async {
                  if (proteinController.text.isEmpty ||
                      fatsController.text.isEmpty ||
                      carbsController.text.isEmpty ||
                      fiberController.text.isEmpty ||
                      sugarController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                        "Value can't be empty!"));
                  }
                  else{
                    int protein=int.parse(proteinController.text);
                    int fats=int.parse(fatsController.text);
                    int fiber=int.parse(fiberController.text);
                    int carbs=int.parse(carbsController.text);
                    int sugar=int.parse(sugarController.text);
                    await  _viewModel.setUpYourProfile(AppData().user?.id,protein,carbs,fiber,sugar,fats);

                  }

                }),
              ),
              const SizedBox(height: 50,)
            ],
          ),

          Consumer<ProfileViewModel>(builder: (context,_viewModel,child){
            if(_viewModel.loading) {
              return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent,));
            }
            return Container();
          }),
        ],
      ),
    ),);
  }
}
