import 'package:flutter/material.dart';
import 'package:hackbanglore24/features/user/presentation/screens/profile_display_screen.dart';
import 'package:hackbanglore24/features/user/presentation/widgets/star_rating_widget.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';

class FreelancersScreen extends StatelessWidget {
  const FreelancersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Freelancer"),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileDisplayScreen()));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMediumSize, vertical: kSmallSize),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2017/11/02/14/26/model-2911329_1280.jpg'),
                  ),
                  const SizedBox(width: kMediumSize,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Deepesh", style: Theme.of(context).textTheme.headlineSmall,),
                      const SizedBox(height: 4,),
                      Text("Software Developer | +2 years exp", style: Theme.of(context).textTheme.labelMedium,),
                      const SizedBox(height: 4,),
                      const StarRatingWidget(ratingCount: 5)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
