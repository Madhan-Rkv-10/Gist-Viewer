import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';

// Providers (defined outside main for better organization)
final gistsProvider = StateProvider<List<dynamic>>((_) => []);
final isLoadingProvider = StateProvider<bool>((_) => false);
final hasMoreProvider = StateProvider<bool>((_) => true);
final pageProvider = StateProvider<int>((_) => 1);

final gistNotifierProvider =
    StateNotifierProvider<GistNotifier, List<dynamic>>((ref) {
  final gists = ref.read(gistsProvider);
  return GistNotifier(gists, ref);
});

class GistNotifier extends StateNotifier<List<dynamic>> {
  final Ref ref;
  GistNotifier(super.initialGists, this.ref);

  Future<void> fetchGists(String username, int perPage) async {
    final page = ref.read(pageProvider.notifier).state;
    final isLoading = ref.read(isLoadingProvider);
    final hasMore = ref.read(hasMoreProvider);

    if (hasMore && !isLoading) {
      ref.read(isLoadingProvider.notifier).state = true;

      String url =
          "https://api.github.com/users/$username/gists?page=$page&per_page=$perPage";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData.isEmpty) {
          ref.read(hasMoreProvider.notifier).state = false;
        } else {
          state = state..addAll(decodedData);
          ref.read(pageProvider.notifier).state++;
        }
      } else {
        throw Exception('Failed to load gists');
      }

      ref.read(isLoadingProvider.notifier).state = false;
    }
  }
}

class GistPage extends HookConsumerWidget {
  const GistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gists = ref.watch(gistsProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final hasMore = ref.watch(hasMoreProvider);
    final fetchGists = ref.watch(gistNotifierProvider.notifier);
    const username = "Madhan-Rkv-10"; // Replace with actual username
    const perPage = 10;

    final scrollController = useScrollController();

    useEffect(() {
      void listener() {
        if (scrollController.position.extentAfter == 0 && hasMore) {
          fetchGists.fetchGists(username, perPage);
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [fetchGists, hasMore]);

    return MaterialApp(
      title: 'GitHub Gists',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Gists'),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
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
      ),
    );
  }
}

void main() {
  runApp(const ProviderScope(child: GistPage()));
}
