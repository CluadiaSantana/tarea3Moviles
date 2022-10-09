import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/book_bloc.dart';

class Viewbook extends StatelessWidget {
  const Viewbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
                BlocProvider.of<BookBloc>(context).add(BookReturnSearchEvent());
              }),
              icon: Icon(Icons.arrow_back)),
          title: const Text('Detalles del libro'),
          actions: [
            IconButton(
                onPressed: (() {
                  BlocProvider.of<BookBloc>(context).add(BookShareEvent());
                }),
                icon: Icon(Icons.share))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            child: _detailBook(),
          ),
        ));
  }

  BlocConsumer<BookBloc, BookState> _detailBook() {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is BookAllTextState) {
          Map<String, dynamic> book = state.details;
          return _details(context, book, book["texto"]);
        } else if (state is BookSubTextState) {
          Map<String, dynamic> book = state.details;
          return _details(context, book, book["textosub"]);
        }
        return Text("Error");
      },
    );
  }

  Column _details(context, Map<String, dynamic> book, String texto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(30),
          height: 300,
          child: _image(book),
        ),
        Text(
          book["title"],
          style: TextStyle(fontSize: 33),
          textAlign: TextAlign.center,
        ),
        _text(context, texto, book["fecha"], book["pag"])
      ],
    );
  }

  Image _image(Map<String, dynamic> book) {
    if (book["ima"] != null) {
      return Image.network(
        book["ima"],
        fit: BoxFit.fitHeight,
      );
    }
    return Image.asset(
      "assets/file.jpg",
      fit: BoxFit.fitHeight,
    );
  }

  Container _text(context, String texto, String fecha, String paginas) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fecha,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Paginas: " + paginas),
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              texto,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              BlocProvider.of<BookBloc>(context).add(BookTextButtonEvent());
            },
          ),
        ],
      ),
    );
  }
}
