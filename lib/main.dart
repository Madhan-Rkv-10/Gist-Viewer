import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gist_downloader/all_gist.dart';
import 'package:gist_downloader/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'download_file.dart';

///
/// home page enter gist user name
/// navigate -> screen
///
/// all gist with two button,run, download
///

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends HookConsumerWidget {
  final String username = "github_username";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(
              allowSnapshotting: false,
            ),
          },
        )),
        home:
            //  const HomePage()

            const HomeScreen());
  }
}

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Gists'),
        backgroundColor: const Color.fromARGB(255, 153, 84, 210),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: TextField(
              controller: textController,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AllGist()));
                }
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AllGist()));
                        }
                      },
                      icon: Icon(Icons.send)),
                  labelText: "GIST USER",
                  hintText: "Enter GIST USER NAME"),
            ),
          ),
        ],
      ),
    );
  }
}
