import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/features/client/data/repository/client_repository.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';

class ClientDashboard extends ConsumerWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(clientRepositoryProvider).getProject();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
        child: project == null
            ? const Center(
                child: Text("No project found!"),
              )
            : ListView.builder(itemBuilder: (context, index) {
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
                            _infoBox("\$${project.duration} days", "Duration",
                                context),
                            _infoBox("\$${project.cost}", "Pricing", context),
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
                        )
                      ],
                    ),
                  ),
                );
              }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.go('/client-dashboard/add-project');
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
