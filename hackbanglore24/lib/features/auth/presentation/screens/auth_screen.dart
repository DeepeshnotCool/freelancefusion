import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackbanglore24/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hackbanglore24/utils/constants/size_constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ValueNotifier<UserType> userType = ValueNotifier(UserType.client);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMediumSize),
              child: Column(
                children: [
                      const SizedBox(height: 100,),
                  const CircleAvatar(radius: 60,),
                  const SizedBox(height: kLargeSize,),
                  ValueListenableBuilder(
                    valueListenable: userType,
                    builder: (context, value, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _userTypeButton("I'm \nClient", 'assets/client.jpg', value == UserType.client,
                              (){
                            userType.value = UserType.client;
                              }),
                          _userTypeButton("I'm \nFreelancer", 'assets/freelancer.jpg', value == UserType.freelancer, (){
                            userType.value = UserType.freelancer;
                          }),
                        ],
                      );
                    }
                  ),
                  const SizedBox(height: kLargeSize,),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text("Email")
                    ),
                  ),
                  const SizedBox(height: kMediumSize,),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text("Password")
                    ),
                  ),
                  const SizedBox(height: kLargeSize,),

                  ElevatedButton(onPressed: (){
                    ref.read(authControllerProvider.notifier).login(userType.value);
                  }, child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kLargeSize, vertical: kMediumSize),
                    child: Text("Login"),
                  ))
                ],
              ),
            ),
          ),
        );
      }
    );
  }


  Widget _userTypeButton(String title, String imagePath, bool isSelected, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: isSelected ? Border.all(color: Colors.green, width: 5) : null,
              borderRadius: BorderRadius.circular(kMediumSize+4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kMediumSize),
              child: Container(
                height: 240,
                width: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover)
                ),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black54,
                              Colors.blueGrey
                            ]
                          )
                        ),
                        child: Text(title, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center,))),
              ),
            ),
          ),
          const SizedBox(height: kMediumSize,),

        ],
      ),
    );
  }
}
