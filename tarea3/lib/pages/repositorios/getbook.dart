import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class httpReq {
  static final httpReq _singleton = httpReq._internal();

  factory httpReq() {
    return _singleton;
  }

  httpReq._internal();

  Future searchBook(String book) async {
    try {
      String url = 'https://www.googleapis.com/books/v1/volumes?q=$book';
      var response = await http.get(Uri.parse(url));
      final result = jsonDecode(response.body);
      return result;
    } catch (e) {
      return 'error';
    }
  }
}
