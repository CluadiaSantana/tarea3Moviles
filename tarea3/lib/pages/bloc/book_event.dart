part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class BookSearchEvent extends BookEvent {
  final String buscar;

  BookSearchEvent({required this.buscar});
}

class BookDetailsEvent extends BookEvent {
  final Map<String, dynamic> allinformation;

  BookDetailsEvent({required this.allinformation});
}

class BookReturnSearchEvent extends BookEvent {}

class BookTextButtonEvent extends BookEvent {}

class BookShareEvent extends BookEvent {}
