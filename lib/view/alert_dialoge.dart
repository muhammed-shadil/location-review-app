import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/controller/review_bloc/review_bloc.dart';
import 'package:location_review_app/model/user_model.dart';

Future<void> showReviewDialog(
    BuildContext context, Map<String, dynamic> user) async {
  final TextEditingController commentController = TextEditingController();
  final reviewBloc = BlocProvider.of<ReviewBloc>(context);
  final formKey = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (context) {
      return BlocListener<ReviewBloc, ReviewState>(
        listener: (context, state) {
          log('current state is $state');
        },
        child: AlertDialog(
          title: const Text('Add Review'),
          content: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: commentController,
              decoration: const InputDecoration(labelText: 'Comment'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  log('current state of form ${formKey.currentState}');
                  BlocProvider.of<ReviewBloc>(context).add(
                      Addreview(comment: commentController.text, user: user));
                }
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    },
  );
}
