import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding

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

Future<List<dynamic>> fetchGists(String username) async {
  var url = Uri.parse('https://api.github.com/users/$username/gists');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load gists');
  }
}
