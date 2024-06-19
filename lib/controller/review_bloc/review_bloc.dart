import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<Addreview>(addreview);
    // on<fetchmarker>(fetchMarker);
  }

  FutureOr<void> addreview(Addreview event, Emitter<ReviewState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection("locations")
          .doc(event.user['latitude'].toString())
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

  // FutureOr<void> fetchMarker(fetchmarker event, Emitter<ReviewState> emit) {
  //   emit(fetchmarkerState(markers: event.fetchedMarkers));
  }
// }
