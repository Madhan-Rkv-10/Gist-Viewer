import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Providers/repo_provider.dart';
import 'all_gist.dart';

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
              onChanged: (value) {
                ref.read(userNameProvider.notifier).state = value;
              },
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
                      icon: const Icon(Icons.send)),
                  labelText: "GIST USER",
                  hintText: "Enter GIST USER NAME"),
            ),
          ),
        ],
      ),
    );
  }
}
