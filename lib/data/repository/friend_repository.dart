import '../../service/local_db_service_friend.dart';
import '../model/friend_model.dart';

class FriendRepository {
  FriendLocalDatabase? dbFriend;

  FriendRepository({required this.dbFriend});

  void addFriend(FriendModel friend) async => await dbFriend!.addFriend(friend);

Future<List<FriendModel>> readFriend() async {
  var result = await dbFriend!.getFriends();
  return result.map((json) => FriendModel.fromJson(json)).toList();
}
  
  void updateFriend(FriendModel friendModel, int id) async =>
      await dbFriend!.updateFriend(friendModel, id);

  void deleteFriend(int id) async => await dbFriend!.deleteFriend(id);
}
