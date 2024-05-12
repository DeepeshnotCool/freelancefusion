import 'dart:convert';

import 'package:flutter/services.dart';
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

  Future<List<AddProjectModel>> getProjectList() async {
    String data = await rootBundle.loadString('assets/data/jobs.json');
    final List<dynamic> jsonData = json.decode(data);
    final jobsList = jsonData.map((e) => AddProjectModel.fromJson(e)).toList();
    return jobsList;
    print(jsonData);
    final jobs = addProjectModelFromJson(data);
    return jobs;
  }


}