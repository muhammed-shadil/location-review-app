 import 'package:flutter/material.dart';

Future<void> showReviewDialog(BuildContext context) async {
    final TextEditingController commentController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Review'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(labelText: 'Comment'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
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