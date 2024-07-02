import 'dart:convert';

import '../models/user_gist_response_model.dart';
import 'package:http/http.dart' as http;

class GistRepo {
  Future<GistList> fetchGists(String username, {int page = 1}) async {
    var url =
        Uri.parse('https://api.github.com/users/$username/gists?page=$page');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GistList.fromJson(data);
    } else {
      throw MyException(data['message']);
    }
  }
}


class MyException implements Exception {
  MyException(this.message);
  final String message;
  @override
  String toString() {
    return message;
  }
}
