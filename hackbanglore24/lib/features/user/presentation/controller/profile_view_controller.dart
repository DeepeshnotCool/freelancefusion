import 'package:hackbanglore24/features/user/data/models/profile_linked_data.dart';
import 'package:hackbanglore24/features/user/data/repository/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_view_controller.g.dart';

@riverpod
Future<ProfileLinkedInData> profileViewController(ProfileViewControllerRef ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return await repo.getLinkedInProfile();
}