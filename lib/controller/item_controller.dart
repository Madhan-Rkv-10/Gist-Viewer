import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../Providers/repo_provider.dart';
import '../models/item.dart';
import '../models/pagination_controller_mixin.dart';
import '../models/pagination_request.dart';
import '../models/pagination_response.dart';

// final itemsController = AsyncNotifierProvider.autoDispose<ItemsController,
//     PaginationResponse<Item>>(ItemsController.new);

// class ItemsController extends AutoDisposeAsyncNotifier<PaginationResponse<Item>>
//     with PaginationController<Item> {
//   @override
//   Future<PaginationResponse<Item>> build() async {
//     return await loadData(const PaginationRequest(page: 1, perPage: 30));
//   }

//   @override
//   FutureOr<PaginationResponse<Item>> loadData(PaginationRequest query) {
//     return ref.read(itemRepoProvider).getItemByPagePaginate(query);
//   }
// }
