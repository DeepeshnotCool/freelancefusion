import 'package:hackbanglore24/utils/shared_prefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_controller.g.dart';

enum UserType{freelancer, client}

@riverpod
class AuthController extends _$AuthController {
  @override
  LoginStates build() {
    return init();
  }

  final userTypeKey = 'user-type-key';
  final loggedStatusKey = 'is-logged-in';

  LoginStates init(){
    final isLoggedIn = ref.read(sharedPrefsProvider).getBool(loggedStatusKey);
    if(isLoggedIn == true){
      final userType = getUserType();
      return LoggedInState(userType: userType);
    }else{
      return LoggedOutState();
    }
  }

  void login(UserType userType){
    ref.read(sharedPrefsProvider).setBool(loggedStatusKey, true);
    ref.read(sharedPrefsProvider).setString(userTypeKey, userType.name);
    state = LoggedInState(userType: userType);
  }

  void logOut(){
    ref.read(sharedPrefsProvider).remove(loggedStatusKey);
    state = LoggedOutState();
  }


  UserType getUserType(){
    final type = ref.read(sharedPrefsProvider).getString(userTypeKey);
    if(type == UserType.client.name){
      return UserType.client;
    }
    return UserType.freelancer;
  }

}

abstract class LoginStates{}

class LoggedInState extends LoginStates{
  final UserType userType;
  LoggedInState({required this.userType});
}

class LoggedOutState extends LoginStates{}


