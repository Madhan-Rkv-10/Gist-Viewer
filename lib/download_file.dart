import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'all_gist.dart';
import 'models/user_gist_response_model.dart'; // For JSON decoding

Future<void> downloadFile(String url, String filename) async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    print('File downloaded: ${file.path}');
  } else {
    print('Failed to download file: $filename');
  }
}

class GistRepo {
  Future<GistList> fetchGists(String username) async {
    var url = Uri.parse('https://api.github.com/users/$username/gists');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GistList.fromJson(data);
    } else {
      throw Exception('Failed to load gists');
    }
  }
}

final repoProvider = Provider((ref) => GistRepo());

final class ErrorModel {
  final String error;

  ErrorModel({required this.error});
}

final gistFutureProvider = FutureProviderFamily((Ref ref, String arg) async {
  final provider = ref.watch(repoProvider);
  final data = await provider.fetchGists(arg);
  return data;
});
