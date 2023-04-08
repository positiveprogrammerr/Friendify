import 'package:database_app/data/model/friend_model.dart';
import 'package:database_app/view_model/friends_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/star_rating.dart';

class FriendDetailPage extends StatelessWidget {
  final FriendModel friend;

  const FriendDetailPage({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final isImageColor = Provider.of<FriendViewModel>(context,listen: false).imageNum;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isImageColor
            ? const Color.fromARGB(255, 14, 49, 79)
            : const Color.fromARGB(255, 109, 9, 59),
        title: Text("Friend Details",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,fontSize: 24),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: friend.image != null
                  ? Hero(
                    tag: friend.id!,
                    child: Image.memory(
                        friend.image!,
                        fit: BoxFit.cover,
                      ),
                  )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      color: Colors.black,
                    ),
                  ),
                 const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Age:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    const  SizedBox(width: 16),
                      Text(
                        friend.age.toString(),
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontFamily: GoogleFonts.lato().fontFamily,
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Number:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                          fontFamily: GoogleFonts.lato().fontFamily
                        ),
                      ),
                   const  SizedBox(width: 16),
                      Text(
                        friend.number,
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontFamily: GoogleFonts.lato().fontFamily
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Rate',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                          fontFamily: GoogleFonts.lato().fontFamily
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
          ],
        ),
      ),
    );
  }
}
