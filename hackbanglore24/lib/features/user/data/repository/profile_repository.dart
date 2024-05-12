import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hackbanglore24/features/user/data/models/profile_linked_data.dart';
import 'package:hackbanglore24/features/user/data/models/profile_model.dart';
import 'package:hackbanglore24/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return ProfileRepository(prefs);
}

class ProfileRepository {
  final SharedPreferences preferences;

  ProfileRepository(this.preferences);

  final profileKey = 'profile';

  Future<void> saveProfileData(ProfileModel profile) async {
    await preferences.setString(profileKey, jsonEncode(profile.toJson()));
  }

  ProfileModel? getProfile() {
    final data = preferences.getString(profileKey);
    if (data == null) return null;
    final json = jsonDecode(data);
    return ProfileModel.fromJson(json);
  }

  Future<ProfileLinkedInData> getLinkedInProfile() async {
    String data = await rootBundle.loadString('assets/data/profile.json');
    final jsonResult = json.decode(data);
    final linkedInData = ProfileLinkedInData.fromJson(jsonResult);
    return linkedInData;
  }
}
