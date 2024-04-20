// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../models/item.dart';
// import '../models/pagination_request.dart';
// import '../models/pagination_response.dart';
// import '../models/user_gist_response_model.dart';

// final itemRepoProvider = Provider((ref) => ItemRepo());

// class ItemRepo {
//   Future<PaginationResponse<GistList>> getItemByPagePaginate(
//       PaginationRequest request) async {
//     await Future.delayed(const Duration(seconds: 1));

//     // return PaginationResponse(
//     //     data:
//     //         //
//     //         // List.generate(
//     //         //     request.perPage,
//     //         //     (index) => Item(
//     //         //         id: (request.page + index).toString(),
//     //         //         name: "name ${request.page + index}")),
//     //     meta: MetaData(
//     //         page: request.page, perPage: request.perPage, totalPage: 10));

//   }
// }

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user_gist_response_model.dart';

// page size
const limit = 10;

final dioProvider = Provider((_) {
  // const baseUrl = 'https://catfact.ninja';
  // final options = BaseOptions(baseUrl: baseUrl);
  // return Dio(options);
});

final paginatedCatsProvider = FutureProvider.family<GistList, int>(
  (ref, page) async {
    final dio = ref.read(dioProvider);
    final params = {'limit': limit, 'page': page + 1};
    final res = await dio.get('/facts', queryParameters: params);
    return GistList.fromJson(res.data);
  },
  dependencies: [dioProvider],
);

final totalCatCountProvider = Provider<AsyncValue<int>>(
  (ref) => ref.watch(paginatedCatsProvider(0)).whenData((e) => 300),
  dependencies: [paginatedCatsProvider],
);

final listIndexProvider = Provider<int>((_) {
  throw UnimplementedError();
});

final catAtIndexProvider = Provider.family<AsyncValue<Gist>, int>(
  (ref, index) {
    final page = index ~/ limit;
    final indexOnPage = index % limit;

    final res = ref.watch(paginatedCatsProvider(page));
    return res.whenData((e) => e.allGist![indexOnPage]);
  },
  dependencies: [paginatedCatsProvider],
);
