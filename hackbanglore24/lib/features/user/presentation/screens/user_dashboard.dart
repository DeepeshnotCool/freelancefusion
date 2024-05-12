import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/features/user/presentation/screens/jobs_screen.dart';
import 'package:hackbanglore24/features/user/presentation/screens/profile_display_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, tabIndex, _) {
        return Consumer(
          builder: (context, ref, _) {
            return Scaffold(
              appBar: AppBar(
                // title: Text('Hello, User'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(onPressed: (){
                    ref.read(authControllerProvider.notifier).logOut();
                  }, icon: const Icon(Icons.logout))
                ],
              ),
              body: tabIndex == 0 ? JobScreen() : ProfileDisplayScreen(),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabIndex,
                onTap: (index){
                  selectedIndex.value = index;
                },
                selectedItemColor: Colors.green,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.add_chart_outlined), label: 'Jobs'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            );
          }
        );
      }
    );
  }
}
