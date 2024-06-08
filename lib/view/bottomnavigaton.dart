import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/view/homeScreen.dart';
import 'package:location_review_app/view/login_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const BottomNavigationWrapper(),
    );
  }
}

class BottomNavigationWrapper extends StatelessWidget {
  const BottomNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Sign out"),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("data"),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              icon: Icon(Icons.home)),
          actions: [
            IconButton(
                onPressed: () {
                  authBloc.add(LogoutEvent());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LoginScreenWrapper()),
                      (route) => false);
                },
                icon: const Icon(Icons.login_outlined))
          ],
        ),
        body: const Text("data"),
      ),
    );
  }
}
