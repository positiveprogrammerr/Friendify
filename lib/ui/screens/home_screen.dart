import 'package:database_app/ui/widgets/choose_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:database_app/ui/screens/all_friends_page.dart';
import 'package:database_app/view_model/friends_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FriendViewModel>(
        builder: (context, friendViewModel, child) {
          final isImage = friendViewModel.imageNum;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isImage
                      ? const Color.fromARGB(255, 14, 49, 79)
                      : const Color.fromARGB(255, 109, 9, 59),
                  isImage
                      ? const Color.fromARGB(255, 10, 37, 60).withOpacity(0.8)
                      : const Color.fromARGB(255, 109, 9, 59).withOpacity(0.8),
                  isImage
                      ? const Color.fromARGB(255, 7, 31, 51).withOpacity(0.7)
                      : const Color.fromARGB(255, 109, 9, 59).withOpacity(0.7),
                  const Color.fromARGB(255, 204, 172, 172).withOpacity(1),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add your Friend',
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChooseButton(
                      assetPath: isImage
                          ? friendViewModel.image[2]
                          : friendViewModel.image[3],
                      navigate: 'home',
                    ),
                    GestureDetector(
                      onTap: () {
                        friendViewModel.readFriend();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FriendsShowPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2.5,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Text(
                            'My Friends',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}
