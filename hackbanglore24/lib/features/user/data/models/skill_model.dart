
class SkillModel{
  late final String id;
  final String skillName;
  final String skillLevel;
  SkillModel({required this.skillName, required this.skillLevel}){
    id = DateTime.now().toIso8601String();
  }

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
    skillName: json["skillName"],
    skillLevel: json["skillLevel"],
  );

  Map<String, dynamic> toJson() => {
    "skillName": skillName,
    "skillLevel": skillLevel,
  };

}