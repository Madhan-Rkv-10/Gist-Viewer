import 'package:flutter/material.dart';

import 'download_file.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final String username = "github_username";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Gists'),
          backgroundColor: const Color.fromARGB(255, 153, 84, 210),
        ),
        body: FutureBuilder(
          future: fetchGists("slightfoot"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var gist = snapshot.data?[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(gist['files'].keys.join(", ")),
                      tileColor: Colors.grey[300],
                      trailing: IconButton.filled(
                          color: Colors.white,
                          onPressed: () {
                            gist['files'].forEach((filename, file) {
                              downloadFile(file['raw_url'], filename);
                            });
                          },
                          icon: const Icon(Icons.download)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onTap: () {},
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
