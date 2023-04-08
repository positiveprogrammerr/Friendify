import 'package:database_app/view_model/friends_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/choose_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 1, 19, 36),
              const Color.fromARGB(255, 2, 16, 29).withOpacity(0.8),
              const Color.fromARGB(255, 4, 17, 29).withOpacity(0.7),
              const Color.fromARGB(255, 49, 42, 42),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChooseButton(
                  assetPath: Provider.of<FriendViewModel>(context).image[0],
                  navigate: 'enter0',
                ),
                ChooseButton(
                  assetPath: Provider.of<FriendViewModel>(context).image[1],
                  navigate: 'enter1',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
