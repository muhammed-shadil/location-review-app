import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/Glassbox.dart';
import 'package:location_review_app/constants.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/model/user_model.dart';
import 'package:location_review_app/textfield.dart';
import 'package:location_review_app/view/login_screen.dart';

class SignupScreenWrapper extends StatelessWidget {
  const SignupScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SignupScreen(),
    );
  }
}

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedError) {
            // LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is AuthLoading) {
            // LoadingDialog.show(context);
          } else if (state is Networkauthenticatederor) {
            // LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No  intrnet connection !!!"),
              ),
            );
          } else if (state is Authenticated) {
            // LoadingDialog.hide(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreenWrapper()),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sign up successfully"),
                ),
              );
            });
          }
        },
        child: Stack(
          children: [
            Container(
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
                  height: MediaQuery.of(context).size.height * 0.76,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Form(
                        key: constants.signupkey,
                        child: Column(
                          children: [
                            const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: mainTextfield(
                                controller: emailcontroller,
                                text: 'Enter your email',
                                obscuretext: true,
                                preficsicon: Icons.abc,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a valid email";
                                  } else if (!constants.regemail
                                      .hasMatch(value)) {
                                    return "Please enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            mainTextfield(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: mainTextfield(
                                controller: namecontroller,
                                text: 'Enter your name',
                                obscuretext: true,
                                preficsicon: Icons.abc,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter name";
                                  } else if (!constants.name.hasMatch(value)) {
                                    return "Enter a valid name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: mainTextfield(
                                keyboard: TextInputType.phone,
                                controller: phonecontroller,
                                text: 'Enter your phone number',
                                obscuretext: true,
                                preficsicon: Icons.abc,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter phone number";
                                  } else if (value.length > 10) {
                                    return "number must be 10";
                                  } else if (!constants.phonreg
                                      .hasMatch(value)) {
                                    return "Please enter a valid number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              margin: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (constants.signupkey.currentState!
                                      .validate()) {
                                    Usermodel usermode = Usermodel(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                        phone: phonecontroller.text,
                                        username: namecontroller.text);

                                    BlocProvider.of<AuthBloc>(context)
                                        .add(SignUpEvent(user: usermode));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: constants.black,
                                    foregroundColor: constants.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text(
                                  "Sign up",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))),
            Align(
              alignment: const Alignment(-0.8, -0.9),
              child: Glassbox(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios)))),
            ),
          ],
        ),
      ),
    );
  }
}
