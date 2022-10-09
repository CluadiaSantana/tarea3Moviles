import 'package:flutter/material.dart';
import 'package:tarea3/pages/bloc/book_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea3/pages/viewbook.dart';
import 'package:tarea3/pages/search.dart';

class HomePage extends StatelessWidget {
  final _buscar = TextEditingController();

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libreria free to play'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _buscar,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        BlocProvider.of<BookBloc>(context)
                            .add(BookSearchEvent(buscar: _buscar.value.text));
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                  labelText: 'Ingresa Titulo',
                  labelStyle: TextStyle(color: Colors.grey)),
            ),
          ),
          _view()
        ],
      ),
    );
  }

  BlocConsumer<BookBloc, BookState> _view() {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookDetailState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Viewbook()));
        }
      },
      builder: (context, state) {
        if (state is BookSearchState) {
          return Search();
        } else if (state is BookNullSearchState) {
          return _home("No se ha encontrado ningun libro");
        } else if (state is BookSuccessfulSearchState) {
          return Expanded(
            child: GridView.builder(
              itemCount: state.json.length,
              itemBuilder: (context, index) {
                return _gridView(state.json, index, context);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          );
        }
        return _home("Ingrese palabra para buscar libro");
      },
    );
  }

  Container _gridView(List<dynamic> books, int index, context) {
    String title = books[index]['volumeInfo']['title'];
    title = title.length < 35 ? title : title.substring(0, 35) + "...";
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (() {
              BlocProvider.of<BookBloc>(context)
                  .add(BookDetailsEvent(allinformation: books[index]));
            }),
            icon: _image(
                books[index]['volumeInfo']['imageLinks']?['smallThumbnail']),
            iconSize: 125,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )),
    );
  }

  Image _image(dynamic ima) {
    if (ima != null) {
      return Image.network(
        ima,
        fit: BoxFit.fitHeight,
      );
    }
    return Image.asset(
      "assets/file.jpg",
      fit: BoxFit.fitHeight,
    );
  }

  Expanded _home(String textView) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(textView)],
    ));
  }
}
