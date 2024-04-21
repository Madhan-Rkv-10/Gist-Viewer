import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Providers/repo_provider.dart';
import '../models/user_gist_response_model.dart';

class AllGistControllerNotifier extends AutoDisposeAsyncNotifier<GistList> {
  @override
  FutureOr<GistList> build() async {
    currentPage = 1;
    getGistList();
    return GistList.empty();
  }

  int currentPage = 1;
  bool hasMore = true;
  Future<void> getGistList() async {
    final repo = ref.watch(repoProvider);
    final name = ref.watch(userNameProvider);

    if (hasMore) {
      try {
        final data = await AsyncValue.guard(
            () => repo.fetchGists(name, page: currentPage));

        if (data.value != null && data.value!.allGist != null) {
          if (data.value!.allGist!.isEmpty) {
            hasMore = false;
          }

          final currentGistList = state.value!.allGist ?? [];
          final newGistList = [...currentGistList, ...data.value!.allGist!];
          state = AsyncValue.data(GistList(allGist: newGistList));

          currentPage++;
        } else {
          if (kDebugMode) {
            print("Error fetching gists or empty data received");
          }
        }
        log("${state.requireValue.allGist?.length}");
      } catch (e) {
        state = AsyncValue.error(
            e.toString(), StackTrace.fromString("an ErrorOccured"));
      }
    } else {
      if (kDebugMode) {
        print("no more data");
      }
    }
  }
}
