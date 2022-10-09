part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class BookHomeEvent extends BookEvent {}

class BookSearchEvent extends BookEvent {
  final String buscar;

  BookSearchEvent({required this.buscar});
}

class BookNullSearchEvent extends BookEvent {}

class BookSuccessfulSearchEvent extends BookEvent {}

class BookDetailsEvent extends BookEvent {
  final Map<String, dynamic> allinformation;

  BookDetailsEvent({required this.allinformation});
}

class BookReturnSearchEvent extends BookEvent {}

class BookTextButtonEvent extends BookEvent {}

class BookShareEvent extends BookEvent {}
