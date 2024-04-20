import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Gists',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GistPage(),
    );
  }
}

class GistPage extends StatefulWidget {
  const GistPage({super.key});

  @override
  State<GistPage> createState() => _GistPageState();
}

class _GistPageState extends State<GistPage> {
  List<dynamic> gists = [];
  bool isLoading = false;

  int page = 1;
  int perPage = 10;

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.extentAfter == 0) {
      _fetchGists();
      return true;
    }
    return false;
  }

  bool hasMore = true;
  Future<void> _fetchGists() async {
    if (hasMore) {
      if (isLoading) return;

      setState(() {
        isLoading = true;
      });

      String username = "Madhan-Rkv-10";
      String url =
          "https://api.github.com/users/$username/gists?page=$page&per_page=$perPage";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          log(response.body.isNotEmpty.toString(), name: "DATA AVAILABLE");
          if (json.decode(response.body).isEmpty) {
            hasMore = false;
          }
          gists.addAll(json.decode(response.body));
          isLoading = false;
          page++; // Increment page for next pagination
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load gists');
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _fetchGists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Gists'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: gists.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title:
                        Text(gists[index]['description'] ?? 'No Description'),
                    subtitle: Text(gists[index]['html_url']),
                  );
                },
              ),
            ),
            isLoading ? const CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
