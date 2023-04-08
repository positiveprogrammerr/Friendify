import 'package:database_app/ui/screens/friend_add_screen.dart';
import 'package:database_app/ui/screens/home_screen.dart';
import 'package:database_app/view_model/friends_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseButton extends StatelessWidget {
  final String assetPath;
  final String navigate;

  const ChooseButton(
  {
    required this.assetPath,
    required this.navigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (navigate == 'enter0') {
          Provider.of<FriendViewModel>(context,listen: false).myBool = true;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(
                ),
              ));
        } else if (navigate == 'enter1') {
            Provider.of<FriendViewModel>(context,listen: false).myBool = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(
                ),
              ));
        } else if (navigate == 'home') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>const AddFriendScreen(),
              ));
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 2.5,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
