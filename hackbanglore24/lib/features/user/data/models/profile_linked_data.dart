
class ProfileLinkedInData {
  String message;
  Result result;

  ProfileLinkedInData({
    required this.message,
    required this.result,
  });

  factory ProfileLinkedInData.fromJson(Map<String, dynamic> json) => ProfileLinkedInData(
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  ReqObj reqObj;
  LinkedinProfile linkedinProfile;
  String userProfileUuid;
  ProfileImage profileImage;

  Result({
    required this.reqObj,
    required this.linkedinProfile,
    required this.userProfileUuid,
    required this.profileImage,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reqObj: ReqObj.fromJson(json["reqObj"]),
    linkedinProfile: LinkedinProfile.fromJson(json["linkedinProfile"]),
    userProfileUuid: json["userProfileUUID"],
    profileImage: ProfileImage.fromJson(json["profileImage"]),
  );

  Map<String, dynamic> toJson() => {
    "reqObj": reqObj.toJson(),
    "linkedinProfile": linkedinProfile.toJson(),
    "userProfileUUID": userProfileUuid,
    "profileImage": profileImage.toJson(),
  };
}

class LinkedinProfile {
  String publicIdentifier;
  String profilePicUrl;
  String backgroundCoverImageUrl;
  String firstName;
  String lastName;
  String fullName;
  int followerCount;
  String occupation;
  String headline;
  String summary;
  String country;
  String countryFullName;
  String city;
  String state;
  List<Experience> experiences;
  List<Education> education;
  List<String> languages;
  List<dynamic> accomplishmentOrganisations;
  List<dynamic> accomplishmentPublications;
  List<dynamic> accomplishmentHonorsAwards;
  List<dynamic> accomplishmentPatents;
  List<AccomplishmentCourse> accomplishmentCourses;
  List<AccomplishmentProject> accomplishmentProjects;
  List<AccomplishmentTestScore> accomplishmentTestScores;
  List<Experience> volunteerWork;
  List<dynamic> certifications;
  int connections;
  List<PeopleAlsoViewed> peopleAlsoViewed;
  List<dynamic> recommendations;
  List<Activity> activities;
  List<dynamic> similarlyNamedProfiles;
  List<dynamic> articles;
  List<dynamic> groups;
  List<String> skills;
  dynamic inferredSalary;
  dynamic gender;
  dynamic birthDate;
  dynamic industry;
  dynamic extra;
  List<dynamic> interests;
  List<dynamic> personalEmails;
  List<dynamic> personalNumbers;

  LinkedinProfile({
    required this.publicIdentifier,
    required this.profilePicUrl,
    required this.backgroundCoverImageUrl,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.followerCount,
    required this.occupation,
    required this.headline,
    required this.summary,
    required this.country,
    required this.countryFullName,
    required this.city,
    required this.state,
    required this.experiences,
    required this.education,
    required this.languages,
    required this.accomplishmentOrganisations,
    required this.accomplishmentPublications,
    required this.accomplishmentHonorsAwards,
    required this.accomplishmentPatents,
    required this.accomplishmentCourses,
    required this.accomplishmentProjects,
    required this.accomplishmentTestScores,
    required this.volunteerWork,
    required this.certifications,
    required this.connections,
    required this.peopleAlsoViewed,
    required this.recommendations,
    required this.activities,
    required this.similarlyNamedProfiles,
    required this.articles,
    required this.groups,
    required this.skills,
    required this.inferredSalary,
    required this.gender,
    required this.birthDate,
    required this.industry,
    required this.extra,
    required this.interests,
    required this.personalEmails,
    required this.personalNumbers,
  });

  factory LinkedinProfile.fromJson(Map<String, dynamic> json) => LinkedinProfile(
    publicIdentifier: json["public_identifier"],
    profilePicUrl: json["profile_pic_url"],
    backgroundCoverImageUrl: json["background_cover_image_url"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    fullName: json["full_name"],
    followerCount: json["follower_count"],
    occupation: json["occupation"],
    headline: json["headline"],
    summary: json["summary"],
    country: json["country"],
    countryFullName: json["country_full_name"],
    city: json["city"],
    state: json["state"],
    experiences: List<Experience>.from(json["experiences"].map((x) => Experience.fromJson(x))),
    education: List<Education>.from(json["education"].map((x) => Education.fromJson(x))),
    languages: List<String>.from(json["languages"].map((x) => x)),
    accomplishmentOrganisations: List<dynamic>.from(json["accomplishment_organisations"].map((x) => x)),
    accomplishmentPublications: List<dynamic>.from(json["accomplishment_publications"].map((x) => x)),
    accomplishmentHonorsAwards: List<dynamic>.from(json["accomplishment_honors_awards"].map((x) => x)),
    accomplishmentPatents: List<dynamic>.from(json["accomplishment_patents"].map((x) => x)),
    accomplishmentCourses: List<AccomplishmentCourse>.from(json["accomplishment_courses"].map((x) => AccomplishmentCourse.fromJson(x))),
    accomplishmentProjects: List<AccomplishmentProject>.from(json["accomplishment_projects"].map((x) => AccomplishmentProject.fromJson(x))),
    accomplishmentTestScores: List<AccomplishmentTestScore>.from(json["accomplishment_test_scores"].map((x) => AccomplishmentTestScore.fromJson(x))),
    volunteerWork: List<Experience>.from(json["volunteer_work"].map((x) => Experience.fromJson(x))),
    certifications: List<dynamic>.from(json["certifications"].map((x) => x)),
    connections: json["connections"],
    peopleAlsoViewed: List<PeopleAlsoViewed>.from(json["people_also_viewed"].map((x) => PeopleAlsoViewed.fromJson(x))),
    recommendations: List<dynamic>.from(json["recommendations"].map((x) => x)),
    activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
    similarlyNamedProfiles: List<dynamic>.from(json["similarly_named_profiles"].map((x) => x)),
    articles: List<dynamic>.from(json["articles"].map((x) => x)),
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    skills: List<String>.from(json["skills"].map((x) => x)),
    inferredSalary: json["inferred_salary"],
    gender: json["gender"],
    birthDate: json["birth_date"],
    industry: json["industry"],
    extra: json["extra"],
    interests: List<dynamic>.from(json["interests"].map((x) => x)),
    personalEmails: List<dynamic>.from(json["personal_emails"].map((x) => x)),
    personalNumbers: List<dynamic>.from(json["personal_numbers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "public_identifier": publicIdentifier,
    "profile_pic_url": profilePicUrl,
    "background_cover_image_url": backgroundCoverImageUrl,
    "first_name": firstName,
    "last_name": lastName,
    "full_name": fullName,
    "follower_count": followerCount,
    "occupation": occupation,
    "headline": headline,
    "summary": summary,
    "country": country,
    "country_full_name": countryFullName,
    "city": city,
    "state": state,
    "experiences": List<dynamic>.from(experiences.map((x) => x.toJson())),
    "education": List<dynamic>.from(education.map((x) => x.toJson())),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "accomplishment_organisations": List<dynamic>.from(accomplishmentOrganisations.map((x) => x)),
    "accomplishment_publications": List<dynamic>.from(accomplishmentPublications.map((x) => x)),
    "accomplishment_honors_awards": List<dynamic>.from(accomplishmentHonorsAwards.map((x) => x)),
    "accomplishment_patents": List<dynamic>.from(accomplishmentPatents.map((x) => x)),
    "accomplishment_courses": List<dynamic>.from(accomplishmentCourses.map((x) => x.toJson())),
    "accomplishment_projects": List<dynamic>.from(accomplishmentProjects.map((x) => x.toJson())),
    "accomplishment_test_scores": List<dynamic>.from(accomplishmentTestScores.map((x) => x.toJson())),
    "volunteer_work": List<dynamic>.from(volunteerWork.map((x) => x.toJson())),
    "certifications": List<dynamic>.from(certifications.map((x) => x)),
    "connections": connections,
    "people_also_viewed": List<dynamic>.from(peopleAlsoViewed.map((x) => x.toJson())),
    "recommendations": List<dynamic>.from(recommendations.map((x) => x)),
    "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
    "similarly_named_profiles": List<dynamic>.from(similarlyNamedProfiles.map((x) => x)),
    "articles": List<dynamic>.from(articles.map((x) => x)),
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "inferred_salary": inferredSalary,
    "gender": gender,
    "birth_date": birthDate,
    "industry": industry,
    "extra": extra,
    "interests": List<dynamic>.from(interests.map((x) => x)),
    "personal_emails": List<dynamic>.from(personalEmails.map((x) => x)),
    "personal_numbers": List<dynamic>.from(personalNumbers.map((x) => x)),
  };
}

class AccomplishmentCourse {
  String name;
  String number;

  AccomplishmentCourse({
    required this.name,
    required this.number,
  });

  factory AccomplishmentCourse.fromJson(Map<String, dynamic> json) => AccomplishmentCourse(
    name: json["name"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
  };
}

class AccomplishmentProject {
  StartsAt startsAt;
  dynamic endsAt;
  String title;
  String description;
  dynamic url;

  AccomplishmentProject({
    required this.startsAt,
    required this.endsAt,
    required this.title,
    required this.description,
    required this.url,
  });

  factory AccomplishmentProject.fromJson(Map<String, dynamic> json) => AccomplishmentProject(
    startsAt: StartsAt.fromJson(json["starts_at"]),
    endsAt: json["ends_at"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "starts_at": startsAt.toJson(),
    "ends_at": endsAt,
    "title": title,
    "description": description,
    "url": url,
  };
}

class StartsAt {
  int day;
  int month;
  int year;

  StartsAt({
    required this.day,
    required this.month,
    required this.year,
  });

  factory StartsAt.fromJson(Map<String, dynamic> json) => StartsAt(
    day: json["day"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "month": month,
    "year": year,
  };
}

class AccomplishmentTestScore {
  String name;
  String score;
  StartsAt? dateOn;
  dynamic description;

  AccomplishmentTestScore({
    required this.name,
    required this.score,
    required this.dateOn,
    required this.description,
  });

  factory AccomplishmentTestScore.fromJson(Map<String, dynamic> json) => AccomplishmentTestScore(
    name: json["name"],
    score: json["score"],
    dateOn: json["date_on"] == null ? null : StartsAt.fromJson(json["date_on"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "score": score,
    "date_on": dateOn?.toJson(),
    "description": description,
  };
}

class Activity {
  String title;
  String link;
  ActivityStatus activityStatus;

  Activity({
    required this.title,
    required this.link,
    required this.activityStatus,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    title: json["title"],
    link: json["link"],
    activityStatus: activityStatusValues.map[json["activity_status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "activity_status": activityStatusValues.reverse[activityStatus],
  };
}

enum ActivityStatus {
  LIKED_BY_DEEPESH_RANJAN_KHATRI
}

final activityStatusValues = EnumValues({
  "Liked by Deepesh Ranjan Khatri": ActivityStatus.LIKED_BY_DEEPESH_RANJAN_KHATRI
});

class Education {
  StartsAt startsAt;
  StartsAt endsAt;
  String fieldOfStudy;
  String degreeName;
  String school;
  dynamic schoolLinkedinProfileUrl;
  dynamic schoolFacebookProfileUrl;
  dynamic description;
  String logoUrl;
  String? grade;
  dynamic activitiesAndSocieties;

  Education({
    required this.startsAt,
    required this.endsAt,
    required this.fieldOfStudy,
    required this.degreeName,
    required this.school,
    required this.schoolLinkedinProfileUrl,
    required this.schoolFacebookProfileUrl,
    required this.description,
    required this.logoUrl,
    required this.grade,
    required this.activitiesAndSocieties,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    startsAt: StartsAt.fromJson(json["starts_at"]),
    endsAt: StartsAt.fromJson(json["ends_at"]),
    fieldOfStudy: json["field_of_study"],
    degreeName: json["degree_name"],
    school: json["school"],
    schoolLinkedinProfileUrl: json["school_linkedin_profile_url"],
    schoolFacebookProfileUrl: json["school_facebook_profile_url"],
    description: json["description"],
    logoUrl: json["logo_url"],
    grade: json["grade"],
    activitiesAndSocieties: json["activities_and_societies"],
  );

  Map<String, dynamic> toJson() => {
    "starts_at": startsAt.toJson(),
    "ends_at": endsAt.toJson(),
    "field_of_study": fieldOfStudy,
    "degree_name": degreeName,
    "school": school,
    "school_linkedin_profile_url": schoolLinkedinProfileUrl,
    "school_facebook_profile_url": schoolFacebookProfileUrl,
    "description": description,
    "logo_url": logoUrl,
    "grade": grade,
    "activities_and_societies": activitiesAndSocieties,
  };
}

class Experience {
  StartsAt startsAt;
  StartsAt? endsAt;
  String company;
  String? companyLinkedinProfileUrl;
  dynamic companyFacebookProfileUrl;
  String title;
  String? description;
  String? location;
  String? logoUrl;
  String? cause;

  Experience({
    required this.startsAt,
    required this.endsAt,
    required this.company,
    required this.companyLinkedinProfileUrl,
    this.companyFacebookProfileUrl,
    required this.title,
    required this.description,
    this.location,
    required this.logoUrl,
    this.cause,
  });

  String get jobTenure => "${startsAt.day}/${startsAt.month}/${startsAt.year}-${endsAt?.day}/${endsAt?.month}/${endsAt?.year}";

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    startsAt: StartsAt.fromJson(json["starts_at"]),
    endsAt: json["ends_at"] == null ? null : StartsAt.fromJson(json["ends_at"]),
    company: json["company"],
    companyLinkedinProfileUrl: json["company_linkedin_profile_url"],
    companyFacebookProfileUrl: json["company_facebook_profile_url"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    logoUrl: json["logo_url"],
    cause: json["cause"],
  );

  Map<String, dynamic> toJson() => {
    "starts_at": startsAt.toJson(),
    "ends_at": endsAt?.toJson(),
    "company": company,
    "company_linkedin_profile_url": companyLinkedinProfileUrl,
    "company_facebook_profile_url": companyFacebookProfileUrl,
    "title": title,
    "description": description,
    "location": location,
    "logo_url": logoUrl,
    "cause": cause,
  };
}

class PeopleAlsoViewed {
  String link;
  String name;
  String summary;
  dynamic location;

  PeopleAlsoViewed({
    required this.link,
    required this.name,
    required this.summary,
    required this.location,
  });

  factory PeopleAlsoViewed.fromJson(Map<String, dynamic> json) => PeopleAlsoViewed(
    link: json["link"],
    name: json["name"],
    summary: json["summary"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "name": name,
    "summary": summary,
    "location": location,
  };
}

class ProfileImage {
  Data data;
  String contentType;

  ProfileImage({
    required this.data,
    required this.contentType,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    data: Data.fromJson(json["data"]),
    contentType: json["contentType"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "contentType": contentType,
  };
}

class Data {
  String type;
  List<int> data;

  Data({
    required this.type,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    data: List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}

class ReqObj {
  String name;
  String jobTitle;
  String bio;
  String linkedinUrl;
  List<Skill> skills;
  String profileUrl;

  ReqObj({
    required this.name,
    required this.jobTitle,
    required this.bio,
    required this.linkedinUrl,
    required this.skills,
    required this.profileUrl,
  });

  factory ReqObj.fromJson(Map<String, dynamic> json) => ReqObj(
    name: json["name"],
    jobTitle: json["jobTitle"],
    bio: json["bio"],
    linkedinUrl: json["linkedinUrl"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    profileUrl: json["profileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "jobTitle": jobTitle,
    "bio": bio,
    "linkedinUrl": linkedinUrl,
    "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
    "profileUrl": profileUrl,
  };
}

class Skill {
  String skillName;
  String skillLevel;

  Skill({
    required this.skillName,
    required this.skillLevel,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    skillName: json["skillName"],
    skillLevel: json["skillLevel"],
  );

  Map<String, dynamic> toJson() => {
    "skillName": skillName,
    "skillLevel": skillLevel,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
