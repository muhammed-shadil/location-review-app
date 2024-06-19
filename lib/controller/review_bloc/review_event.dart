// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent {}

class Addreview extends ReviewEvent {
  String comment;
  final Map<String, dynamic> user;
  Addreview({
    required this.comment,
    required this.user,
  });
}

class fetchmarker extends ReviewEvent {
  Set<Marker> fetchedMarkers;
  fetchmarker({
    required this.fetchedMarkers,
  });
}
