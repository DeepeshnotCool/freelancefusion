import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackbanglore24/features/user/data/repository/profile_repository.dart';
import 'package:hackbanglore24/features/user/presentation/screens/profile_edit_screen.dart';
import 'package:hackbanglore24/features/user/presentation/widgets/star_rating_widget.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';
import 'package:simple_icons/simple_icons.dart';

class ProfileDisplayScreen extends ConsumerWidget {
  const ProfileDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileRepositoryProvider).getProfile();
    if(profile == null) return const ProfileEditScreen();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("${profile.name} - ${profile.jobTitle}",
              style: Theme.of(context).textTheme.titleLarge,),
              background: Stack(
                children: [
                  Image.network('https://cdn.pixabay.com/photo/2017/11/02/14/26/model-2911329_1280.jpg',
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
              Text("Social", style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: kSmallSize,),
              const Row(
                children: [
                  Icon(SimpleIcons.linkedin, color: SimpleIconColors.linkedin,),
                  SizedBox(width: kMediumSize,),
                  Icon(SimpleIcons.github, color: SimpleIconColors.git,),
                ],
              ),

              const SizedBox(height: kMediumSize,),
              Text("Summary", style: Theme.of(context).textTheme.titleLarge,),
              Text(profile.bio),

              const SizedBox(height: kMediumSize,),

              Text("Skills", style: Theme.of(context).textTheme.titleLarge,),
              Wrap(
                spacing: kMediumSize,
                children: [
                  ...profile.skills.map((e) => Chip(label: Text("${e.skillName} (${e.skillLevel})")))
                ],
              ),

              const SizedBox(height: kMediumSize,),

              Text("Reviews", style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: kSmallSize,)
            ])),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
            sliver: SliverList(delegate: SliverChildBuilderDelegate(
                (_, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('A skilled and dedicated developer', style: Theme.of(context).textTheme.titleLarge,),
                      const SizedBox(height: kSmallSize,),
                      const Row(
                        children: [
                          StarRatingWidget(ratingCount: 3), 
                          Text("   |   March 10, 2024")
                        ],
                      ),
                      const SizedBox(height: kSmallSize,),
                      Text("This is demo text of lerem ipsum. "*5),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: kMediumSize),
                        child: Divider(),
                      )
                    ],
                  );
                },
              childCount: 20
            )),
          ),


        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(kLargeSize, 12, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profile.name, style: Theme.of(context).textTheme.headlineLarge,),
                      Text(profile.jobTitle, style: Theme.of(context).textTheme.headlineSmall,),
                      const SizedBox(height: kSmallSize,),
                      const Row(
                        children: [
                          Icon(SimpleIcons.linkedin, color: SimpleIconColors.linkedin,),
                          SizedBox(width: kMediumSize,),
                          Icon(SimpleIcons.github, color: SimpleIconColors.git,),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: kLargeSize),
              child: Divider(),
            ),

            Text("Summary", style: Theme.of(context).textTheme.titleLarge,),
            Text(profile.bio),

            const SizedBox(height: kMediumSize,),

            Text("Skills", style: Theme.of(context).textTheme.titleLarge,),
            Wrap(
              spacing: kMediumSize,
              children: [
                ...profile.skills.map((e) => Chip(label: Text("${e.skillName} (${e.skillLevel})")))
              ],
            ),

            const SizedBox(height: kMediumSize,),

            Text("Reviews", style: Theme.of(context).textTheme.titleLarge,),

            const SizedBox(height: 2000,),

          ],
        ),
      ),
    );
  }
}
