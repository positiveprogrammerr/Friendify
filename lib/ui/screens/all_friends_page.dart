import 'package:database_app/ui/screens/edit_friend.dart';
import 'package:database_app/ui/screens/friend_add_screen.dart';
import 'package:database_app/ui/screens/home_screen.dart';
import 'package:database_app/view_model/friends_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/cupertino_buttons.dart';
import '../widgets/star_rating.dart';
import 'friend_detail_page.dart';

class FriendsShowPage extends StatelessWidget {
  const FriendsShowPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImageColor = Provider.of<FriendViewModel>(context).imageNum;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Friends',
            style: TextStyle(
              fontSize: 24,
              fontFamily: GoogleFonts.lato().fontFamily,
            )),
        backgroundColor: isImageColor
            ? const Color.fromARGB(255, 14, 49, 79)
            : const Color.fromARGB(255, 109, 9, 59),
      ),
      body: Consumer<FriendViewModel>(
        builder: (context, friendModel, child) {
          final friends = friendModel.friends;
          if (friends == null) {
            return Container();
          } else if (friendModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 14, 49, 79),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15),
              physics: const BouncingScrollPhysics(),
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FriendDetailPage(friend: friend),
                        ));
                  },
                  child: Slidable(
                      key: ValueKey(friend.id),
                      endActionPane: ActionPane(
                        extentRatio: 0.58,
                        motion: const ScrollMotion(),
                        children: [
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              IconTextButton(
                                iconData: CupertinoIcons.trash,
                                label: 'Delete',
                                color: CupertinoColors.destructiveRed,
                                onPressed: () {
                                  friendModel.deleteFriend(friend.id!);
                                },
                              ),
                              const SizedBox(width: 7),
                              IconTextButton(
                                iconData: CupertinoIcons.pen,
                                label: 'Edit',
                                color: CupertinoColors.activeGreen,
                                onPressed: () {
                                  friendModel.updateFriend(friend, friend.id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FriendEditScreen(friend: friend),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            height: 150,
                            child: Card(
                              elevation: 2,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: friend.image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Hero(
                                              tag: friend.id!,
                                              child: Image.memory(
                                                friend.image!,
                                                fit: BoxFit.cover,
                                                width: 120,
                                                height: 150,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 17),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            friend.name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily:
                                                  GoogleFonts.lato().fontFamily,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Age:   ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GoogleFonts.lato()
                                                      .fontFamily,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                              Text(
                                                friend.age.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Number:   ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GoogleFonts.lato()
                                                      .fontFamily,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                              Text(
                                                friend.number,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Rate:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GoogleFonts.lato()
                                                      .fontFamily,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              StarRating(
                                                rating: friend.rate,
                                                color: Colors.yellow,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isImageColor
            ? const Color.fromARGB(255, 14, 49, 79)
            : const Color.fromARGB(255, 109, 9, 59),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFriendScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
