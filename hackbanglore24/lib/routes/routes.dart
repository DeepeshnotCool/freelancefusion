import 'package:go_router/go_router.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/features/auth/presentation/screens/auth_screen.dart';
import 'package:hackbanglore24/features/client/presentation/screens/add_project_screen.dart';
import 'package:hackbanglore24/features/client/presentation/screens/client_dashboard.dart';
import 'package:hackbanglore24/features/user/presentation/screens/profile_display_screen.dart';
import 'package:hackbanglore24/features/user/presentation/screens/profile_edit_screen.dart';
import 'package:hackbanglore24/features/user/presentation/screens/user_dashboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authController = ref.watch(authControllerProvider);
  return GoRouter(
      routes: [
    GoRoute(path: '/', builder: (context, state) => AuthScreen(),
        redirect: (context, routeState)async{
          if(authController is LoggedInState){
            if(authController.userType == UserType.freelancer){
              if(!authController.profileFilled){
                return '/edit';
              }
              return '/dashboard';
            }else{
              return '/client-dashboard';
            }
          }
          return null;
        },
        routes: [
      GoRoute(
          path: 'dashboard',
          builder: (context, state) => const UserDashboard()),
      GoRoute(
          path: 'edit', builder: (context, state) => const ProfileEditScreen()),
      GoRoute(
          path: 'profile-view',
          builder: (context, state) => const ProfileDisplayScreen()),
      GoRoute(
          path: 'client-dashboard',
          name: 'client-dashboard',
          builder: (context, state) => ClientDashboard(),
          routes: [
            GoRoute(
                path: 'add-project',
                name: 'add-project',
                builder: (context, state) => AddProjectScreen())
          ]),
    ]),
  ]);
}
