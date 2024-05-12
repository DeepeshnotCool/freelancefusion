import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackbanglore24/features/user/presentation/controller/jobs_controller.dart';

import '../../../../utils/constants/size_constants.dart';

class JobScreen extends ConsumerWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsControllerProvider);
    return Scaffold(
      body: jobs.when(data: (jobsList){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
          child: jobsList.isEmpty
              ? const Center(
            child: Text("No project found"),
          )
              : ListView.builder(
              itemCount: jobsList.length,
              itemBuilder: (context, index) {
                final project = jobsList[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kMediumSize, horizontal: kMediumSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoBox("\$ ${project.cost}", "Pricing", context),
                        _infoBox("${project.duration} days", "Duration",
                            context),
                        _infoBox(project.cost, "Pricing", context),
                      ],
                    ),
                    const SizedBox(
                      height: kLargeSize,
                    ),
                    Text(
                      "Job Description",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(project.projectDescription),
                    const SizedBox(
                      height: kLargeSize,
                    ),
                    Text(
                      "Skills Required",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      spacing: kSmallSize,
                      children: [
                        ...project.skillsRequired
                            .map((e) => Chip(label: Text(e)))
                      ],
                    ),

                    const SizedBox(height: kMediumSize,),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: Colors.green),
                          child: const Text("Apply for this job", style: TextStyle(color: Colors.white),),
                          onPressed: (){}),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      }, error: (e, s) => Text(e.toString()), loading: () => CircularProgressIndicator()),
    );
  }

  Widget _infoBox(String title, String subTitle, BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(kSmallSize)),
      padding: const EdgeInsets.symmetric(vertical: kSmallSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.apply(fontWeightDelta: 2),
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.labelSmall,
          )
        ],
      ),
    );
  }
}
