part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

class ReviewSuccessState extends ReviewState {}

class ReviewErrorState extends ReviewState {}
