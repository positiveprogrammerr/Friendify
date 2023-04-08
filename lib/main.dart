import 'package:database_app/data/repository/friend_repository.dart';
import 'package:database_app/service/local_db_service_friend.dart';
import 'package:database_app/view_model/friends_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'ui/screens/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => FriendViewModel(
              friendRepository:
                  FriendRepository(dbFriend: FriendLocalDatabase()),
            )),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Friends App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
