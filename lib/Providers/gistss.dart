// import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../../services/api/api_service.dart';
// import '../../profile/models/profile.dart';
// import '../models/auth_state.dart';
// import '../models/login.dart';

// part 'auth_state.g.dart';

// /// The current authentication state of the app.
// ///
// /// This notifier is responsible for saving/removing the token and profile info
// /// to the storage through the [login] and [logout] methods.
// @riverpod
// class CurrentAuthState extends _$CurrentAuthState {
//   final _tokenBox = Hive.box<String>('token');
//   final _profileBox = Hive.box<Profile>('profile');

// @override
// AuthState build() {
//   final token = _tokenBox.get('current');
//   return token != null ? AuthState.authenticated : AuthState.unauthenticated;
// }

//   /// Attempts to log in with [data] and saves the token and profile info to storage.
//   /// Will invalidate the state if success.
//   Future<void> login(Login data) async {
//     final (profile, token) = await ref.read(apiServiceProvider).login(data);

//     // Save the new [token] and [profile] to Hive box.
//     _tokenBox.put('current', token);
//     _profileBox.put('current', profile);

//     ref
//       // Invalidate the state so the auth state will be updated to authenticated.
//       ..invalidateSelf()
//       // Invalidate the API service so that it will use the new token.
//       ..invalidate(apiServiceProvider);
//   }

//   /// Logs out, deletes the saved token and profile info from storage, and invalidates
//   /// the state.
//   void logout() {
//     // Delete the current [token] and [profile] from Hive box.
//     _tokenBox.delete('current');
//     _profileBox.delete('current');

//     ref
//       // Invalidate the state so the auth state will be updated to unauthenticated.
//       ..invalidateSelf()
//       // Invalidate the API service so that it will no longer use the previous token.
//       ..invalidate(apiServiceProvider);
//   }
// }
import 'package:gist_downloader/models/user_gist_response_model.dart';
import 'package:http/http.dart' as http;

import '../screen/view_gist.dart';

class GistRepo {
  Future<GistList> fetchGists(String username, {int page = 1}) async {
    var url =
        Uri.parse('https://api.github.com/users/$username/gists?page=$page');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GistList.fromJson(data);
    } else {
      throw Exception('Failed to load gists');
    }
  }
}

final repoProvider = Provider((ref) => GistRepo());
final hasMoreProvider = StateProvider((ref) => true);
final pageProvider = StateProvider((ref) => 1);

final mainProvider = AsyncNotifierProvider<AllGistControllerNotifier, GistList>(
    AllGistControllerNotifier.new);

class AllGistControllerNotifier extends AsyncNotifier<GistList> {
  @override
  FutureOr<GistList> build() async {
    currentPage = 1;
    getGistList();
    return GistList.empty();
  }

  int currentPage = 1;
  bool hasMore = true;
  Future<void> getGistList() async {
    // state = const AsyncValue.loading(); // Update UI state to loading if needed
    final repo = ref.watch(repoProvider);

    // final currentPage = ref.watch(pageProvider);

    if (hasMore) {
      final data = await AsyncValue.guard(
          () => repo.fetchGists("slightfoot", page: currentPage));

      if (data.value != null && data.value!.allGist != null) {
        // Check if data and allGist are not null
        if (data.value!.allGist!.isEmpty) {
          hasMore = false;
        }
        // Update state by combining existing and new data
        // state = state.copyWithPrevious(data);
        // state.requireValue.allGist = [
        //   ...state.requireValue.allGist!,
        //   ...data.requireValue.allGist!
        // ];
        // state = data;
        final currentGistList =
            state.value!.allGist ?? []; // Handle potential null
        final newGistList = [...currentGistList, ...data.value!.allGist!];
        state = AsyncValue.data(GistList(allGist: newGistList));

        // state.copyWith(
        //     allGist: [...state.value!.allGist!, ...data.value!.allGist!])

        //     ;

        currentPage++;
        // Increment page only if data is fetched
      } else {
        // Handle potential errors or empty data
        print("Error fetching gists or empty data received");
      }
      log("${state.requireValue.allGist?.length}");
      // print("Error fetching gists or empty data received");
    } else {
      print("no more data");
    }
  }
}

// Future<void> getGistList() async {
//   // state = const AsyncValue.loading();
//   final repo = ref.watch(repoProvider);
//   final hasMore = ref.watch(hasMoreProvider);
//   // final currentPage = ref.watch(pageProvider);
//   // print(state);
//   if (hasMore) {
//     final data = await AsyncValue.guard(
//         () => repo.fetchGists("slightfoot", page: currentPage));
//     if (data.value?.allGist != null) {
//       if (data.value!.allGist!.isEmpty) {
//         ref.read(hasMoreProvider.notifier).state = false;
//       }
//     }
//     // state.value!.allGist!.addAll(data.value!.allGist!);
//     //  = [
//     //   ...state.value!.allGist!,
//     //   ...data.value!.allGist!
//     // ]

//     state = data;
//     //  ref.read(pageProvider.notifier).state += 1;
//     currentPage++;
//   } else {}
// }
void main() {
  runApp(const ProviderScope(
      child: (MaterialApp(
    home: AllGist(),
  ))));
}

class MainScrenProvider extends StatefulHookConsumerWidget {
  const MainScrenProvider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainScrenProviderState();
}

class _MainScrenProviderState extends ConsumerState<MainScrenProvider> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AllGist extends StatefulHookConsumerWidget {
  const AllGist({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllGistState();
}

class _AllGistState extends ConsumerState<AllGist> {
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
      return () => scrollController.removeListener(listener);
    }, [
      ref.read(mainProvider.notifier).getGistList,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Slightfoot"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(mainProvider.notifier).getGistList();
          },
        ),
        body: allgists.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.allGist?.length,
                  controller: scrollController,
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
            error: (e, r) => const Text("Error"),
            loading: () => const Text("data"))

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


/**
 *  Future<void> fetchGists(String username, int perPage) async {
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

 */
