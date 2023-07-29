import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/login_flow/loginProvider.dart';
import 'package:grocery_app/login_flow/profile_viewModel.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../model/userModel.dart';
import '../network_service/service/ApiResponse.dart';
import '../utils/colors.dart';
import '../utils/custom_textField.dart';
import '../utils/textStyles.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  TextEditingController emailController = TextEditingController();
  LoginViewModel _viewModel = LoginViewModel();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _tapGestureRecognizer.onTap = () {
      print("Navigating to Login Screen");
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.bottom ,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 50),
                    child: Column(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              "Hey there, ",
                              style: whiteH1.copyWith(color: Colors.black),
                            )),
                        const Text("Welcome Back",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                customTextField(
                                    prefix: "email.svg",
                                    textEditingController: emailController,
                                    label: "Email Name",
                                    validate: (val) {
                                      return validate(val);
                                    }),
                                const SizedBox(
                                  height: 16,
                                ),
                                customTextField(
                                    prefix: "lock.svg",
                                    textEditingController: passwordController,
                                    label: "Password",
                                    obscure: true,
                                    validate: (val) {
                                      validate(val);
                                    })
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Forgot your password?",
                              style: whiteSubtitle.copyWith(
                                  color: grey2,
                                  decoration: TextDecoration.underline),
                            )),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              gradientButton(
                                "Login",
                                () async {
                                 try{
                                   var resp=await _viewModel
                                       .login(
                                       email: emailController.text,
                                       password: passwordController.text);
                                  User  user= resp?.data;
                                   Navigator.pushAndRemoveUntil(
                                     context,
                                     MaterialPageRoute(builder: (context) {
                                       return  HomeScreen( user: user,);
                                     }),
                                       ModalRoute.withName('/')
                                   );
                                 }
                                 catch(err){
                                   print(err);
                                 }
                                },
                              ),
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
                                  SvgPicture.asset(
                                      "assets/icons/facebook.svg"),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black),
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
                ),
              ),
              Consumer<LoginViewModel>(builder: (context, value, child) {
                if (value.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center();
              })
            ],
          )),
    );
  }

  void validate(String val) {}
}

Widget consumerWidget({required Widget children}) {
  return Consumer<LoginViewModel>(builder: (context, value, child) {
    return children;
  });
}
