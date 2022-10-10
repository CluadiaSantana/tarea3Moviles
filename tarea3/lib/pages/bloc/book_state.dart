part of 'book_bloc.dart';

@immutable
abstract class BookState {}

class BookInitial extends BookState {}

class BookSearchState extends BookState {}

class BookNullSearchState extends BookState {}

class BookSuccessfulSearchState extends BookState {
  final List<dynamic> json;

  BookSuccessfulSearchState({required this.json});
}

class BookAllTextState extends BookState {
  final Map<String, dynamic> details;

  BookAllTextState({required this.details});
}

class BookSubTextState extends BookState {
  final Map<String, dynamic> details;

  BookSubTextState({required this.details});
}

class BookDetailState extends BookState {}
