import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hackbanglore24/features/client/data/models/add_project_model.dart';
import 'package:hackbanglore24/features/client/data/repository/client_repository.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';

import '../../../user/data/models/skill_model.dart';
import '../../../user/presentation/widgets/skill_selection_dialog.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final ValueNotifier<List<SkillModel>> _allSelectedSkills = ValueNotifier([]);
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _constController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Project"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMediumSize, vertical: kMediumSize),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 4,
                      controller: _descriptionController,
                      validator: ValidationBuilder().required().build(),
                      decoration:
                          const InputDecoration(label: Text("Project description")),
                    ),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _durationController,
                            validator: ValidationBuilder().required().build(),
                            decoration: const InputDecoration(
                                label: Text("Duration"), suffix: Text("days")),
                          ),
                        ),
                        const SizedBox(
                          width: kMediumSize,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _constController,
                            validator: ValidationBuilder().required().build(),
                            decoration: const InputDecoration(
                                label: Text("Cost/Hour"), suffix: Text("\$/hour")),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _experienceController,
                      validator: ValidationBuilder().required().build(),
                      decoration: const InputDecoration(
                          label: Text("Experience required"),
                          suffix: Text("years")),
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
                      height: kLargeSize,
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            final List<String> allSkills = _allSelectedSkills.value
                                .map((e) => e.skillName)
                                .toList();
                            final project = AddProjectModel(
                                projectDescription: _descriptionController.text,
                                skillsRequired: allSkills,
                                duration: _durationController.text,
                                cost: _constController.text,
                                experienceLevelRequired:
                                    _experienceController.text);
                            await ref.read(clientRepositoryProvider).saveProjectData(project);
                            context.pop();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kLargeSize, vertical: kMediumSize),
                          child: Text("Submit"),
                        ))
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
        label: const Text("Add required skills"));
  }
}
