import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hackbanglore24/features/user/data/models/skill_model.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';

class SkillSelectionDialog extends StatefulWidget {
  final Function(SkillModel) onSave;

  const SkillSelectionDialog({required this.onSave, super.key});

  @override
  State<SkillSelectionDialog> createState() => _SkillSelectionDialogState();
}

class _SkillSelectionDialogState extends State<SkillSelectionDialog> {
  final List<String> _skills = [
    "Very High",
    "High",
    "Medium",
    "Low",
    "Very Low"
  ];
  String _selectedSkillLevel = "Very High";
  final _skillNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Skill"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _skillNameController,
                  validator: ValidationBuilder().required('Required').build(),
                  decoration: const InputDecoration(label: Text("Skill name")),
                ),
                const SizedBox(
                  height: kMediumSize,
                ),
                Text(
                  "Proficiency",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text("How proficient are you with this skill"),
                const SizedBox(
                  height: kMediumSize,
                ),
                ..._skills.map((e) => RadioListTile(
                    title: Text(e.toUpperCase()),
                    value: e,
                    groupValue: _selectedSkillLevel,
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() {
                        _selectedSkillLevel = val;
                      });
                    }))
              ],
            ),
          ),
        ),
      ),
      actions: [
        MaterialButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        ElevatedButton(
            child: const Text("Save"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final skill = SkillModel(
                    skillName: _skillNameController.text,
                    skillLevel: _selectedSkillLevel);
                widget.onSave(skill);
                Navigator.of(context).pop();
              }
            })
      ],
    );
  }
}
