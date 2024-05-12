import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/features/user/data/models/profile_model.dart';
import 'package:hackbanglore24/features/user/data/repository/profile_repository.dart';
import 'package:hackbanglore24/features/user/presentation/widgets/skill_selection_dialog.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/skill_model.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<List<SkillModel>> _allSelectedSkills = ValueNotifier([]);
  final ValueNotifier<File?> _selectedFile = ValueNotifier(null);
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _bioController = TextEditingController();
  final _linkedInController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: _selectedFile,
                        builder: (context, value, _) {
                          return GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image == null) return;
                              _selectedFile.value = File(image.path);
                            },
                            child: CircleAvatar(
                              radius: 60,
                              // backgroundColor: Colors.grey,
                              backgroundImage: _selectedFile.value == null
                                  ? null
                                  : FileImage(_selectedFile.value!),
                              child: _selectedFile.value != null
                                  ? null
                                  : const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 50,
                                    ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: kLargeSize,
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: ValidationBuilder().required("Required").build(),
                      decoration: const InputDecoration(label: Text("Name")),
                    ),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    TextFormField(
                      controller: _jobTitleController,
                      validator: ValidationBuilder().required("Required").build(),
                      decoration: const InputDecoration(label: Text("Job Title")),
                    ),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    ValueListenableBuilder(
                        valueListenable: _allSelectedSkills,
                        builder: (context, List<SkillModel> value, _) {
                          if (value.isNotEmpty) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(kSmallSize),
                                  border: Border.all(color: Colors.grey)),
                              padding: const EdgeInsets.all(kSmallSize),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      spacing: kMediumSize,
                                      children: [
                                        ...value.map((e) => Chip(
                                              label: Text(
                                                  "${e.skillName} (${e.skillLevel})"),
                                              onDeleted: () {
                                                _allSelectedSkills.value =
                                                    _allSelectedSkills.value
                                                        .where((element) =>
                                                            element.id != e.id)
                                                        .toList();
                                              },
                                            ))
                                      ],
                                    ),
                                  ),
                                  _addSkillWidget()
                                ],
                              ),
                            );
                          }

                          return _addSkillWidget();
                        }),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    TextFormField(
                      controller: _bioController,
                      validator: ValidationBuilder().required("Required").build(),
                      maxLines: 4,
                      decoration: const InputDecoration(label: Text("Bio")),
                    ),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    TextFormField(
                      controller: _linkedInController,
                      validator:
                          ValidationBuilder().required("Required").url().build(),
                      decoration:
                          const InputDecoration(label: Text("LinkedIn profile")),
                    ),
                    const SizedBox(
                      height: kLargeSize,
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            final profile = ProfileModel(
                                name: _nameController.text,
                                jobTitle: _jobTitleController.text,
                                bio: _bioController.text,
                                linkedInUrl: _linkedInController.text,
                                skills: _allSelectedSkills.value,
                                profileUrl: "");
                            await ref.read(profileRepositoryProvider).saveProfileData(profile);
                            ref.read(authControllerProvider.notifier).updateProfile();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kLargeSize, vertical: kMediumSize),
                          child: Text("Submit"),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _addSkillWidget() {
    return ElevatedButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SkillSelectionDialog(
                  onSave: (selectedValue) {
                    _allSelectedSkills.value = [
                      selectedValue,
                      ..._allSelectedSkills.value
                    ];
                  },
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text("Add your skills"));
  }
}
