import 'dart:convert';

import 'package:hackbanglore24/features/client/data/models/add_project_model.dart';
import 'package:hackbanglore24/utils/shared_prefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'client_repository.g.dart';

@riverpod
ClientRepository clientRepository(ClientRepositoryRef ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return ClientRepository(prefs);
}

class ClientRepository{
  final SharedPreferences preferences;
  ClientRepository(this.preferences);

  final projectKey = 'project';

  Future<void> saveProjectData(AddProjectModel project) async{
    await preferences.setString(projectKey, jsonEncode(project.toJson()));
  }

  AddProjectModel? getProject() {
    final data = preferences.getString(projectKey);
    if(data == null) return null;
    final json = jsonDecode(data);
    return AddProjectModel.fromJson(json);
  }
}