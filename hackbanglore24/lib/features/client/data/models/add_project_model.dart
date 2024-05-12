import 'dart:convert';


List<AddProjectModel> addProjectModelFromJson(String str) => List<AddProjectModel>.from(json.decode(str).map((x) => AddProjectModel.fromJson(x)));

class AddProjectModel {
  String projectDescription;
  String duration;
  String cost;
  String experienceLevelRequired;
  List<String> skillsRequired;

  AddProjectModel({
    required this.projectDescription,
    required this.duration,
    required this.cost,
    required this.experienceLevelRequired,
    required this.skillsRequired,
  });

  factory AddProjectModel.fromJson(Map<String, dynamic> json) => AddProjectModel(
    projectDescription: json["projectDescription"],
    duration: json["duration"],
    cost: json["cost"],
    experienceLevelRequired: json["experienceLevelRequired"],
    skillsRequired: List<String>.from(json["skillsRequired"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "projectDescription": projectDescription,
    "duration": duration,
    "cost": cost,
    "experienceLevelRequired": experienceLevelRequired,
    "skillsRequired": List<dynamic>.from(skillsRequired.map((x) => x)),
  };
}
