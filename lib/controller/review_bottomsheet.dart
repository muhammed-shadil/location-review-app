import 'package:flutter/material.dart';
import 'package:location_review_app/model/user_model.dart';
import 'package:location_review_app/view/alert_dialoge.dart';

showBottomSheets(BuildContext context,Map<String, dynamic> user) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
                child: Text(
              "REVIEWS",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  showReviewDialog(context,user);
                  // Add button functionality
                },
                child: Icon(Icons.add),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Item 1'),
              onTap: () {
                // List tile functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Item 2'),
              onTap: () {
                // List tile functionality
              },
            ),
            // Add more list tiles as needed
          ],
        ),
      );
    },
  );
}
