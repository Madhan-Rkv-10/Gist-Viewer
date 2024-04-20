import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gist_downloader/models/user_gist_response_model.dart';
import 'package:gist_downloader/screen/view_gist.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'download_file.dart';

// class AllGists extends StatefulWidget {
//   const AllGists({super.key});

//   @override
//   State<AllGists> createState() => _AllGistsState();
// }

// class _AllGistsState extends State<AllGists> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Slightfoot"),
//       ),
//       body: FutureBuilder(
//         future: fetchGists("slightfoot"),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             }
//             return ListView.builder(
//               itemCount: snapshot.data?.length,
//               itemBuilder: (context, index) {
//                 var gist = snapshot.data?[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(gist['files'].keys.join(", ")),
//                     tileColor: Colors.grey[300],
//                     trailing: IconButton.filled(
//                         color: Colors.white,
//                         onPressed: () {
//                           gist['files'].forEach((filename, file) {
//                             downloadFile(file['raw_url'], filename);
//                           });
//                         },
//                         icon: const Icon(Icons.download)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                     onTap: () {},
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
class AllGist extends StatefulHookConsumerWidget {
  const AllGist({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllGistState();
}

class _AllGistState extends ConsumerState<AllGist> {
  @override
  Widget build(BuildContext context) {
    final allgists = ref.watch(gistFutureProvider("slightfoot"));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Slightfoot"),
        ),
        body: allgists.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.allGist?.length,
                  itemBuilder: (context, index) {
                    final gist = data.allGist!.elementAt(index);
                    FileDetails? fileDetails;
                    fileDetails = gist.files?.values.first;

                    // SchedulerBinding.instance.addPostFrameCallback(
                    //   (timeStamp) {
                    //     for (int i = 0;
                    //         i < gist.files!.keys.toList().length - 1;
                    //         i++) {
                    //       log("${gist.files?.values.elementAt(i).rawUrl}",
                    //           name: "KEYVALUES");
                    //       fileDetails = gist.files?.values.elementAt(i);
                    //     }
                    //   },
                    // );

                    return ListTile(
                      title: Text("${gist.files?.keys}"),
                      onTap: () {
                        final url = fileDetails?.rawUrl;
                        List<String> segments = url!.split('/');
                        String secondToLastSegment =
                            segments[segments.length - 4];
                        log("${secondToLastSegment}");

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GistViewer(
                                  id: secondToLastSegment,
                                )));

                        // gist.files?.entries.first.
                      },
                    );
                  });
            },
            error: (e, r) => Text("Error"),
            loading: () => Text("data"))

        // FutureBuilder(
        //   future: fetchGists("slightfoot"),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasError) {
        //         return Text("Error: ${snapshot.error}");
        //       }
        //       return ListView.builder(
        //         itemCount: snapshot.data?.length,
        //         itemBuilder: (context, index) {
        //           var gist = snapshot.data?[index];
        //           return Padding(
        //             padding: const EdgeInsets.all(8),
        //             child: ListTile(
        //               title: Text(gist['files'].keys.join(", ")),
        //               tileColor: Colors.grey[300],
        //               trailing: IconButton.filled(
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     gist['files'].forEach((filename, file) {
        //                       downloadFile(file['raw_url'], filename);
        //                     });
        //                   },
        //                   icon: const Icon(Icons.download)),
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(8)),
        //               onTap: () {},
        //             ),
        //           );
        //         },
        //       );
        //     } else {
        //       return const CircularProgressIndicator();
        //     }
        //   },
        // ),

        );
  }
}
