import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tarea3/pages/repositorios/getbook.dart';
import 'package:share_plus/share_plus.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final ht = httpReq();
  List<dynamic> busqueda = [];
  Map<String, dynamic> actual = {};
  bool stat = false;
  BookBloc() : super(BookInitial()) {
    on<BookSearchEvent>(_search);
    on<BookDetailsEvent>(_detail);
    on<BookReturnSearchEvent>(_return);
    on<BookTextButtonEvent>(_text);
    on<BookShareEvent>(_share);
  }

  FutureOr<void> _search(BookSearchEvent event, Emitter<BookState> emit) async {
    emit(BookSearchState());
    try {
      dynamic response = await ht.searchBook(event.buscar);
      if (response['totalItems'] > 0) {
        List result = response['items'];
        print(result.length);
        busqueda = result;
        emit(BookSuccessfulSearchState(json: result));
      } else {
        emit(BookNullSearchState());
      }
    } catch (e) {}
  }

  FutureOr<void> _detail(BookDetailsEvent event, Emitter<BookState> emit) {
    print(event.allinformation);
    Map<String, dynamic> book = event.allinformation;
    dynamic ima = book['volumeInfo']['imageLinks']?['smallThumbnail'];
    dynamic title = book['volumeInfo']?['title'] != null
        ? book['volumeInfo']['title']
        : "-";
    dynamic texto = book['volumeInfo']?['description'] != null
        ? book['volumeInfo']['description']
        : "-";
    dynamic fecha = book['volumeInfo']?['publishedDate'] != null
        ? book['volumeInfo']['publishedDate']
        : "-";
    dynamic paginas = book['volumeInfo']?['pageCount'] != null
        ? book['volumeInfo']['pageCount']
        : "-";
    dynamic textosub =
        texto.length > 270 ? (texto.substring(0, 270) + "...") : texto;
    try {
      paginas = paginas.toString();
    } catch (e) {}
    Map<String, dynamic> pass = {
      "ima": ima,
      "title": title,
      "fecha": fecha,
      "pag": paginas,
      "texto": texto,
      "textosub": textosub
    };
    actual = pass;
    emit(BookDetailState());
    emit(BookSubTextState(details: pass));
  }

  FutureOr<void> _return(BookReturnSearchEvent event, Emitter<BookState> emit) {
    emit(BookSuccessfulSearchState(json: busqueda));
  }

  FutureOr<void> _text(BookTextButtonEvent event, Emitter<BookState> emit) {
    if (state is BookSubTextState) {
      emit(BookAllTextState(details: actual));
    } else {
      emit(BookSubTextState(details: actual));
    }
  }

  FutureOr<void> _share(BookShareEvent event, Emitter<BookState> emit) {
    Share.share("Tiulo: ${actual["title"]} \nPaginas: ${actual["pag"]}");
  }
}
