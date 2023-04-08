// ignore_for_file: avoid_print, unused_local_variable, duplicate_ignore

import 'package:sqflite/sqflite.dart';
import '../data/model/friend_model.dart';

class FriendLocalDatabase {
  Database? dbFriend;
  String tableName = "friends";

  FriendLocalDatabase();

  Future<Database> getDb() async {
    if (dbFriend == null) {
      dbFriend = await createDatabase();
      return dbFriend!;
    }
    return dbFriend!;
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = '$databasesPath/friends.db';

    var database = await openDatabase(dbPath,
        version: 2, onCreate: populateDb, onUpgrade: onUpgrade);

    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute("DROP TABLE IF EXISTS $tableName");
    populateDb(database, newVersion);
  }

  void populateDb(Database database, int version) async {
    await database.execute('CREATE TABLE $tableName ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT, '
        'age INTEGER, '
        'number TEXT, '
        'rate INTEGER, '
        'image BLOB'
        ')');
  }

  Future<void> addFriend(FriendModel friend) async {
    Database db = await getDb();

    var id = await db.insert(tableName, friend.toJson());
  }

  Future<List<Map<String, dynamic>>> getFriends() async {
    Database db = await getDb();

    var result = await db.query(tableName,
        columns: ["id", "name", "rate", "age", "number", "image"]);
    return result.toList();
  }

  Future<void> updateFriend(FriendModel friendModel, int id) async {
    Database db = await getDb();
    // ignore: unused_local_variable
    int rowsAffected = await db.update(tableName, friendModel.toJson(),
        where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteFriend(int id) async {
    Database db = await getDb();
    int rowsAffected =
        await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    print("Friend $id deleted, rows affected: $rowsAffected");
  }
}
