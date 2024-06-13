import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/controller/review_bloc/review_bloc.dart';
import 'package:location_review_app/model/user_model.dart';

Future<void> showReviewDialog(BuildContext context, Map<String, dynamic> user) async {
  final TextEditingController commentController = TextEditingController();
final reviewBloc = BlocProvider.of<ReviewBloc>(context);
  final formKey = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Review'),
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
            decoration: InputDecoration(labelText: 'Comment'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<ReviewBloc>(context).add(
                    Addreview(comment: commentController.text, user: user));
              }
              // final review = Review(
              //   userId: 'user1', // Replace with the current user ID
              //   comment: commentController.text,
              //   timestamp: DateTime.now(),
              // );
              // await addReview(locationId, review);
              Navigator.pop(context);
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}
