
import 'package:hackbanglore24/features/user/data/models/skill_model.dart';

class ProfileModel {
  String name;
  String jobTitle;
  String bio;
  String linkedInUrl;
  List<SkillModel> skills;
  String profileUrl;

  ProfileModel({
    required this.name,
    required this.jobTitle,
    required this.bio,
    required this.linkedInUrl,
    required this.skills,
    required this.profileUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: json["name"],
    jobTitle: json["jobTitle"],
    bio: json["bio"],
    linkedInUrl: json["linkedInUrl"],
    skills: List<SkillModel>.from(json["skills"].map((x) => SkillModel.fromJson(x))),
    profileUrl: json["profileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "jobTitle": jobTitle,
    "bio": bio,
    "linkedInUrl": linkedInUrl,
    "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
    "profileUrl": profileUrl,
  };
}

