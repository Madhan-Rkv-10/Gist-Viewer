import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/gist_controller.dart';
import '../models/user_gist_response_model.dart';
import '../repository/gist_repo.dart';

final repoProvider = Provider((ref) => GistRepo());
final hasMoreProvider = StateProvider((ref) => true);
final pageProvider = StateProvider((ref) => 1);

final mainProvider =
    AsyncNotifierProvider.autoDispose<AllGistControllerNotifier, GistList>(
        AllGistControllerNotifier.new);
final userNameProvider = StateProvider((ref) => "");
