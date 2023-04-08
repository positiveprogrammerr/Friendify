import 'package:database_app/data/model/friend_model.dart';
import 'package:database_app/data/repository/friend_repository.dart';
import 'package:flutter/cupertino.dart';

class FriendViewModel extends ChangeNotifier {
  FriendRepository? friendRepository;
  FriendViewModel({required this.friendRepository});

  List<FriendModel>? friends;
  bool isLoading = false;

  void addFriend(FriendModel friend) async {
    friendRepository!.addFriend(friend);
  }

  void readFriend() async {
    loadingChanger();
    friends = await friendRepository!.readFriend();
    loadingChanger();
  }

  void updateFriend(FriendModel friendModel, int id) async {
    notifyListeners();
    friendRepository!.updateFriend(friendModel, id);
    readFriend();
  }

  void deleteFriend(int id) async {
    friendRepository!.deleteFriend(id);
    readFriend();
  }

  void loadingChanger() {
    isLoading = !isLoading;
    notifyListeners();
  }

  final List<String> _images = [
    'assets/man.png',
    'assets/girl.png',
    'assets/mans.png',
    'assets/girls.png'
  ];

  List<String> get image {
    return _images;
  }

  bool? _image;
  bool get imageNum => _image!;
  set myBool(bool newValue) {
    _image = newValue;
    notifyListeners();
  }
}
