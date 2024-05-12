
class AddProjectModel {
  String projectDescription;
  List<String> skillsRequired;
  String duration;
  String cost;
  String experienceLevelRequired;

  AddProjectModel({
    required this.projectDescription,
    required this.skillsRequired,
    required this.duration,
    required this.cost,
    required this.experienceLevelRequired,
  });

  factory AddProjectModel.fromJson(Map<String, dynamic> json) => AddProjectModel(
    projectDescription: json["projectDescription"],
    skillsRequired: List<String>.from(json["skillsRequired"].map((x) => x)),
    duration: json["duration"],
    cost: json["cost"],
    experienceLevelRequired: json["experienceLevelRequired"],
  );

  Map<String, dynamic> toJson() => {
    "projectDescription": projectDescription,
    "skillsRequired": List<dynamic>.from(skillsRequired.map((x) => x)),
    "duration": duration,
    "cost": cost,
    "experienceLevelRequired": experienceLevelRequired,
  };
}
