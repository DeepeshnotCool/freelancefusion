import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/features/user/presentation/controller/profile_view_controller.dart';
import 'package:hackbanglore24/features/user/presentation/widgets/star_rating_widget.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';
import 'package:simple_icons/simple_icons.dart';

class ProfileDisplayScreen extends ConsumerWidget {
  const ProfileDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileViewControllerProvider);
    final authController = ref.watch(authControllerProvider);

    return Scaffold(
      body: profileController.when(data: (data) {
        final profile = data.result;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "${profile.reqObj.name} - ${profile.reqObj.jobTitle}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,),
                background: Stack(
                  children: [
                    Image.network(
                      'https://cdn.pixabay.com/photo/2017/11/02/14/26/model-2911329_1280.jpg',
                      fit: BoxFit.fitHeight,
                      height: 400,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.blueGrey,
                                  Colors.black45
                                ]
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
              sliver: SliverList(delegate: SliverChildListDelegate([

                const SizedBox(height: kMediumSize,),
                Text("Social", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                const SizedBox(height: kSmallSize,),
                const Row(
                  children: [
                    Icon(SimpleIcons.linkedin, color: SimpleIconColors
                        .linkedin,),
                    SizedBox(width: kMediumSize,),
                    Icon(SimpleIcons.github, color: SimpleIconColors.git,),
                  ],
                ),

                const SizedBox(height: kMediumSize,),
                Text("Summary", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                Text(profile.reqObj.bio),

                const SizedBox(height: kMediumSize,),

                Text("Skills", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                Wrap(
                  spacing: kMediumSize,
                  children: [
                    ...profile.reqObj.skills.map((e) =>
                        Chip(label: Text("${e.skillName} (${e.skillLevel})")))
                  ],
                ),

                const SizedBox(height: kMediumSize,),
                Text("Experience", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                ...profile.linkedinProfile.experiences.map((e) =>
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: kSmallSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.title, style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,),
                          Text("${e.company} | ${e.jobTenure}", style: Theme
                              .of(context)
                              .textTheme
                              .labelSmall,)
                        ],
                      ),
                    )),

                const SizedBox(height: kMediumSize,),
                Text("Reviews", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                const SizedBox(height: kSmallSize,)
              ])),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
              sliver: SliverList(delegate: SliverChildBuilderDelegate(
                      (_, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('A skilled and dedicated developer', style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,),
                        const SizedBox(height: kSmallSize,),
                        Row(
                          children: [
                            StarRatingWidget(ratingCount: Random().nextInt(5)),
                            const Text("   |   March 10, 2024")
                          ],
                        ),
                        const SizedBox(height: kSmallSize,),
                        Text("This is demo text of lerem ipsum. " * 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: kMediumSize),
                          child: Divider(),
                        )
                      ],
                    );
                  },
                  childCount: 3
              )),
            ),
          ],
        );
      }, error: (e, s) => Text(e.toString()),
          loading: () => const CircularProgressIndicator()),
      floatingActionButton: (authController is LoggedInState &&
          authController.userType == UserType.client) ? FloatingActionButton
          .extended(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text("Your Feedback"),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        label: Text("Skill"),
                        hintText: "eg. Highly Proficient"
                    ),
                  ),
                  SizedBox(height: kMediumSize,),
                  TextField(
                    decoration: InputDecoration(
                        label: Text("Recommendation"),
                        hintText: "eg. Highly Recommended"
                    ),
                  ),
                  SizedBox(height: kMediumSize,),
                  TextField(
                    decoration: InputDecoration(
                        label: Text("Submission Timing"),
                        hintText: "eg. On Time submission"
                    ),
                  ),
                  SizedBox(height: kMediumSize,),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: const Text("Submit"),)
              ],
            );
          });
        },
        icon: const Icon(Icons.feedback_outlined),
        label: const Text("Add your feedback"),
      ) : null,
    );
  }
}
