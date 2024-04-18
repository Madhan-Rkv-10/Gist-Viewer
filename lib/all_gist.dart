import 'package:flutter/material.dart';

import 'download_file.dart';

class AllGists extends StatefulWidget {
  const AllGists({super.key});

  @override
  State<AllGists> createState() => _AllGistsState();
}

class _AllGistsState extends State<AllGists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
