import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_review_app/view/alert_dialoge.dart';

showBottomSheets(BuildContext context, Map<String, dynamic> user) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                    showReviewDialog(context, user);
                    // Add button functionality
                  },
                  child: const Icon(Icons.add),
                ),
              ),
              SizedBox(
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("locations")
                        .doc(user['latitude'].toString())
                        .collection("reviews")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("data");
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final reviewdata =
                                snapshot.data!.docs[index].data();

                            return ListTile(
                              leading: const Icon(Icons.list),
                              title: Text(reviewdata["userName"]),
                              subtitle: Text(reviewdata["reviewText"]),
                              onTap: () {
                                // List tile functionality
                              },
                            );
                          }, separatorBuilder: (BuildContext context, int index) { return const Divider(endIndent: 10,indent: 10,); },
                        );
                      }
                      return const Text(
                          "datassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
                    }),
              ),

              // ListTile(
              //   leading: Icon(Icons.list),
              //   title: Text('Item 2'),
              //   onTap: () {
              //     // List tile functionality
              //   },
              // ),
              // Add more list tiles as needed
            ],
          ),
        ),
      );
    },
  );
}
