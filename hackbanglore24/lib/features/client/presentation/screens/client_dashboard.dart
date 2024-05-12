import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/features/client/presentation/screens/add_project_screen.dart';
import 'package:hackbanglore24/features/client/presentation/screens/freelancers_screen.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';

import '../../../user/presentation/controller/jobs_controller.dart';

class ClientDashboard extends ConsumerWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsController = ref.watch(jobsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Projects"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logOut();
              },
              icon: const Icon(Icons.login))
        ],
      ),
      body: jobsController.when(data: (jobs){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
          child: jobs.isEmpty
              ? const Center(
            child: Text("No project found!"),
          )
              : ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final project = jobs[index];
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
                          child: const Text("See best fit for this job", style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FreelancersScreen()));
                          }),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      }, error: (e, s) => Text(e.toString()),
          loading: () => CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // context.go('/client-dashboard/add-project');
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProjectScreen()));
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Project")),
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
