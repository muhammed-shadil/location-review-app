import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/Glassbox.dart';
import 'package:location_review_app/constants.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/textfield.dart';
import 'package:location_review_app/view/bottomnavigaton.dart';
import 'package:location_review_app/view/signup_screen.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedError) {
            // LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    "No user Found with this email or password did not match "),
              ),
            );
          } else if (state is AuthLoading) {
            const CircularProgressIndicator();
            // LoadingDialog.show(context);
            // const CustomLoadingAnimation();
          } else if (state is Authenticated) {
            // LoadingDialog.hide(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const BottomNavigation()),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("You are Logged in"),
                ),
              );
            });
          }
        },
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "asset/fff2946959.jpg",
                    ),
                    fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Glassbox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.509,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    key: constants.loginkey,
                    child: Column(
                      children: [
                        const Text(
                          "LOgin",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: mainTextfield(
                            controller: emailcontroller,
                            text: 'Enter your email',
                            obscuretext: true,
                            preficsicon: Icons.abc,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid email";
                              } else if (!constants.regemail.hasMatch(value)) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: mainTextfield(
                            controller: passwordcontroller,
                            text: 'Enter you password',
                            obscuretext: true,
                            preficsicon: Icons.abc,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a password";
                              } else if (!constants.paswd.hasMatch(value)) {
                                return 'Password should contain at least one upper case, one lower case, one digit, one special character and  must be 8 characters in length';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const SignupScreenWrapper()));
                          },
                          child: const Text(
                            "Don't you have an account signup?",
                            style: TextStyle(color: constants.white),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          margin: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (constants.loginkey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    LoginEvent(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: constants.black,
                                foregroundColor: constants.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              "login",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))),
      ),
    );
  }
}
