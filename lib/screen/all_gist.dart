import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Providers/repo_provider.dart';
import '../models/user_gist_response_model.dart';
import 'view_gist.dart';

class AllGist extends StatefulHookConsumerWidget {
  const AllGist({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllGistState();
}

class _AllGistState extends ConsumerState<AllGist> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allgists = ref.watch(mainProvider);
    final scrollController = useScrollController();

    useEffect(() {
      listener() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          ref.read(mainProvider.notifier).getGistList();
        }
      }

      scrollController.addListener(listener);
      return () => [
            scrollController.removeListener(listener),
          ];
    }, [
      ref.read(mainProvider.notifier).getGistList,
    ]);
    final userName = ref.watch(userNameProvider);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: Colors.purple,
          title: Text(
            userName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     ref.read(mainProvider.notifier).getGistList();
        //   },
        // ),
        body: allgists.when(
            data: (data) {
              // final org = data.allGist ?? [];
              // if (org.isNotEmpty) {
              return ListView.builder(
                  itemCount: data.allGist?.length,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    final gist = data.allGist!.elementAt(index);
                    FileDetails? fileDetails;
                    fileDetails = gist.files?.values.first;

                    return ListTile(
                      title: Text("${gist.files?.keys}"),
                      onTap: () {
                        final url = fileDetails?.rawUrl;
                        List<String> segments = url!.split('/');
                        String secondToLastSegment =
                            segments[segments.length - 4];
                        log(secondToLastSegment);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GistViewer(
                                  id: secondToLastSegment,
                                )));
                      },
                    );
                  });
              // } else {
              //   return const Center(
              //     child: Text("No GIST AVAILABLE"),
              //   );
              // }
            },
            error: (e, r) {
              // Navigator.of(context).pop(e);

              return Center(
                child: Text(
                  "User ${e.toString()}",
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
            loading: () => const Text("data")));
  }
}
