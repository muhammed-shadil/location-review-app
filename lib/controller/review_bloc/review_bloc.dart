import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_review_app/model/user_model.dart';
import 'package:meta/meta.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<Addreview>(addreview);
  }

  FutureOr<void> addreview(Addreview event, Emitter<ReviewState> emit) {
    try {
      FirebaseFirestore.instance
          .collection("locations")
          .doc(event.user['latitude'])
          .collection("reviews")
          .add({
        'userName': event.user["username"],
        'reviewText': event.comment,
      });
      emit(ReviewSuccessState());
    } catch (e) {
      emit(ReviewErrorState());
    }
  }
}
