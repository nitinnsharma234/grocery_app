import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/login_flow/profile_viewModel.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/custom_textField.dart';
import '../utils/strings.dart';
import '../utils/textStyles.dart';
import '../utils/utils.dart';

class ProfileComplete extends StatefulWidget {
  final String? uid;
  const ProfileComplete( { required this.uid,Key? key}) : super(key: key);

  @override
  State<ProfileComplete> createState() => _ProfileCompleteState();
}

class _ProfileCompleteState extends State<ProfileComplete> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = "Male";
  DateTime selectedDate = DateTime.now();
  TextEditingController proteinController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController fiberController = TextEditingController();
  ProfileViewModel _viewModel=ProfileViewModel();


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
    print(widget.uid);
    MediaQueryData mediaquery = MediaQuery.of(context);
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: AnimatedContainer(
          height: mediaquery.size.height - mediaquery.padding.bottom,
          duration: const Duration(seconds: 2),
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/trackGoal.svg",
                      fit: BoxFit.cover,
                      width: mediaquery.size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 8.0, left: 16, right: 16),
                      child: Text(
                        Strings.completeProfile,
                        style: whiteH1Bold.copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: Text(
                        Strings.knowMessage,
                        style: whiteSubtitle.copyWith(color: grey1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: getTextField(selectedValue, (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      }),
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
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: customNutritionalInfo(
                          carbsController, "weightscale.svg", "Carbs", context),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: customNutritionalInfo(
                          sugarController, "weightscale.svg", "Sugar", context),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
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
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child:

                      gradientButton("Next", () async {
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
                         await  _viewModel.setUpYourProfile(widget.uid!,protein,carbs,fiber,sugar,fats);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return  HomeScreen(user: _viewModel.user!,);
                            }),
                          );
                        }

                      }),
                    ),
                  ],
                ),
                Consumer<ProfileViewModel>(
                  builder: (context,value,child){
                    print(value.loading);
                   return value.loading?SizedBox(height:mediaquery.size.height,child: const Center(child: CircularProgressIndicator(color: Colors.black,),)):const Center();
                  },
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}

Widget getTextField(
  String selectedValue,
  Function(String) callback,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: DropdownButtonFormField(
      isExpanded: false,
      value: selectedValue,
      borderRadius: BorderRadius.circular(16),
      alignment: AlignmentDirectional.bottomEnd,
      style: whiteSubtitle.copyWith(color: Colors.black),
      dropdownColor: borderColor,
      decoration: InputDecoration(
        labelText: "Choose Gender",
        labelStyle: TextStyle(color: Color(0xFFAEA3A5), fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        isDense: true,
        prefixIcon: SvgPicture.asset(
          "assets/icons/userIcon.svg",
          fit: BoxFit.scaleDown,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        fillColor: borderColor,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: inputBorderColor, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: inputBorderColor, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(16)),
      ),
      onChanged: (newValue) {
        callback(newValue!);
      },
      items: <String>["Male", "Female"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}

Widget titleContainer(String tittle) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Text(
      tittle,
      style: whiteH4Medium,
    ),
    decoration: BoxDecoration(gradient: purpleGradient),
  );
}

Widget iconContainer(IconData icon, Function() onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration:
          const BoxDecoration(gradient: blueGradient, shape: BoxShape.circle),
      padding: const EdgeInsets.all(4.0),
      child: Icon(
        icon,
        size: 20,
      ),
    ),
  );
}

Widget customNutritionalInfo(TextEditingController textController,
    String prefixIcon, String label, BuildContext context) {
  return Row(
    children: [

      Expanded(
        child: customTextField(
            textEditingController: textController,
            prefix: prefixIcon,
            enabled: false,
            label: "$label per 100gm",
            onlyDigit: true),
      ),
      const SizedBox(
        width: 10,
      ),
      iconContainer(Icons.remove, () {
        if (textController.text.isEmpty) {
          textController.text = '1';
        }
        int a = int.parse(textController.text);
        if (a >= 1) {
          a--;
        }
        textController.text = a.toString();
      }),
      const SizedBox(
        width: 20,
      ),
      iconContainer(Icons.add, () {
        if (textController.text.isEmpty) {
          textController.text = '0';
        }
        int a = int.parse(textController.text);
        if (a < 30) {
          a++;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar("Cannot exceed than 30"));
        }
        textController.text = a.toString();
      }),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

getSnackBar(String message) {
  return SnackBar(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.only(bottom: 30.0, left: 100, right: 100),
    content: Text(
      message,
      style: const TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    ),
  );
}
