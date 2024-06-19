// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

class ReviewSuccessState extends ReviewState {}

class ReviewErrorState extends ReviewState {}

class fetchmarkerState extends ReviewState {
  Set<Marker> markers;
  fetchmarkerState({
    required this.markers,
  });
}
