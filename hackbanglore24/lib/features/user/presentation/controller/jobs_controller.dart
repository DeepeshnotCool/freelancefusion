import 'package:hackbanglore24/features/client/data/models/add_project_model.dart';
import 'package:hackbanglore24/features/client/data/repository/client_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'jobs_controller.g.dart';

@riverpod
class JobsController extends _$JobsController {
  @override
  FutureOr<List<AddProjectModel>> build() async {
    final repo = ref.watch(clientRepositoryProvider);
    final jobsList = await repo.getProjectList();
    return jobsList;
  }
}