import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/login_flow/login_screnn.dart';
import 'package:grocery_app/login_flow/profile_completion.dart';
import 'package:grocery_app/network_service/service/ApiResponse.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/custom_textField.dart';
import '../utils/textStyles.dart';
import '../utils/utils.dart';
import 'loginProvider.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);
  static String route="/registration";
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  final LoginViewModel _viewModel = LoginViewModel();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _tapGestureRecognizer.onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }),
      );
    };
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tapGestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 26.0, right: 26, top: 24),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(
                            "Hey there, ",
                            style: whiteH1.copyWith(color: Colors.black),
                          )),
                      const Text("Create an Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              customTextField(
                                  prefix: "accountIcon.svg",
                                  textEditingController: fNameController,
                                  label: "First Name",
                                  validate: (val) {
                                    return validate(val,InputField.FirstName);
                                  }),
                              const SizedBox(
                                height: 16,
                              ),
                              customTextField(
                                  prefix: "accountIcon.svg",
                                  textEditingController: lNameController,
                                  label: "Last Name",
                                  validate: (val) {
                                    return validate(val,InputField.LastName);
                                  },),
                              const SizedBox(
                                height: 16,
                              ),
                              customTextField(
                                  prefix: "email.svg",
                                  textEditingController: emailController,
                                  label: "Email Name",
                                  validate: (val) {
                                    return validate(val,InputField.Email);
                                  },),
                              const SizedBox(
                                height: 16,
                              ),
                              customTextField(
                                  prefix: "lock.svg",
                                  textEditingController: passwordController,
                                  label: "Password",
                                  validate: (val) {
                                    return validate(val,InputField.Password);
                                  },
                                  obscure: true)
                            ],
                          ),
                        ),
                      ),
                      CheckboxListTile(
                        value: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        activeColor: blueThemeColor,
                        contentPadding: const EdgeInsets.all(0),
                        onChanged: (val) {},
                        title: RichText(
                          text: const TextSpan(
                            text: 'By continue you accept our ',
                            style: TextStyle(fontSize: 13, color: grey1),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Privacy Policy ',
                                style:
                                    TextStyle(decoration: TextDecoration.underline),
                              ),
                              TextSpan(text: 'and '),
                              TextSpan(
                                text: 'Terms of Use ',
                                style:
                                    TextStyle(decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            gradientButton("Register", () async  {
                              _formKey.currentState!.validate();
                              try {
                               var resp=await _viewModel.registration(
                                    firstName: fNameController.text,
                                    lastName: lNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              // _formKey.currentState?.reset();
                               UserCredential data=resp?.data;
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) {
                                   return  ProfileComplete(uid:data?.user?.uid);
                                 }),
                               );

                              }
                              catch(err){
                                print(err.toString());
                              }
                            }),
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Text("Or")),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/icons/google.png"),
                                const SizedBox(
                                  width: 30,
                                ),
                                SvgPicture.asset("assets/icons/facebook.svg"),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: const TextStyle(fontSize: 13, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Log In',
                                      style: whiteSubtitleBold.copyWith(
                                          color: blueThemeColor),
                                      recognizer: _tapGestureRecognizer),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<LoginViewModel>(
                  builder: (context,value,child){
                    if(value.loading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const Center();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validate(String val,InputField field) {
    print(val);
    if(val.isEmpty)
    {
      return "Cannot be Empty";
    }
    switch(field){
      case InputField.FirstName:

        break;

      case InputField.LastName:

        break;
      case InputField.Email:
        return validateEmail(val);
        break;
      case InputField.Password:
          print(val);
          if(val.length<6){
           return  "Password should be more than 6 characters";
          }
        break;
    }
   // print("Returning null");
    return null;
  }

  resetState(String val) {
    if(val.length==1) {
      _formKey.currentState!.validate();
    }
  }
}


enum InputField{
  FirstName,LastName,Email,Password;
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}