// import 'package:flutter/material.dart';
// import 'package:gist_downloader/all_gist.dart';

// import 'download_file.dart';

// ///
// /// home page enter gist user name
// /// navigate -> screen
// ///
// /// all gist with two button,run, download
// ///

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   final String username = "github_username";

//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           pageTransitionsTheme: const PageTransitionsTheme(
//         builders: <TargetPlatform, PageTransitionsBuilder>{
//           TargetPlatform.android: ZoomPageTransitionsBuilder(
//             allowSnapshotting: false,
//           ),
//         },
//       )),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('GitHub Gists'),
//           backgroundColor: const Color.fromARGB(255, 153, 84, 210),
//         ),
//         body: Column(
//           children: [
//             const SizedBox(
//               height: 100,
//               child: TextField(
//                 decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: "GIST USER",
//                     hintText: "Enter GIST USER NAME"),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future: fetchGists("slightfoot"),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Text("Error: ${snapshot.error}");
//                     }

//                     return ListView.builder(
//                       itemCount: snapshot.data?.length,
//                       itemBuilder: (context, index) {
//                         var gist = snapshot.data?[index];
//                         return Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: ListTile(
//                             title: Text(gist['files'].keys.join(", ")),
//                             tileColor: Colors.grey[300],
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 TextButton(
//                                     onPressed: () {}, child: Text("View")),
//                                 IconButton.filled(
//                                     color: Colors.white,
//                                     onPressed: () {
//                                       gist['files'].forEach((filename, file) {
//                                         downloadFile(file['raw_url'], filename);
//                                       });
//                                     },
//                                     icon: const Icon(Icons.download)),
//                               ],
//                             ),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8)),
//                             onTap: () {
//                               Navigator.of(context).push(
//                                 PageRouteBuilder(
//                                   pageBuilder: (context,
//                                           Animation<double> double,
//                                           paageBuilder) =>
//                                       AllGists(),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return SizedBox.square(
//                         child: const CircularProgressIndicator());
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
