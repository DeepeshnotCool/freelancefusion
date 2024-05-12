import 'package:hackbanglore24/utils/shared_prefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_controller.g.dart';

enum UserType{freelancer, client}
const profileDataFillKey = 'firs-login-key';

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
      final profileFilled = ref.read(sharedPrefsProvider).getBool(profileDataFillKey);
      return LoggedInState(userType: userType, profileFilled: profileFilled ?? false);
    }else{
      return LoggedOutState();
    }
  }

  void updateProfile()async{
    await ref.read(sharedPrefsProvider).setBool(profileDataFillKey, true);
    state = LoggedInState(userType: UserType.freelancer, profileFilled: true);
  }

  void login(UserType userType){
    ref.read(sharedPrefsProvider).setBool(loggedStatusKey, true);
    ref.read(sharedPrefsProvider).setString(userTypeKey, userType.name);
    final profileFilled = ref.read(sharedPrefsProvider).getBool(profileDataFillKey);
    state = LoggedInState(userType: userType, profileFilled: profileFilled ?? false);
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
  final bool profileFilled;
  LoggedInState({required this.userType, required this.profileFilled});
}

class LoggedOutState extends LoginStates{}


