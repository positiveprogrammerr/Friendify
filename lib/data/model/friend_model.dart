import 'dart:typed_data';

class FriendModel {
   final int? id;
  final String name;
  final int age;
  final String number;
  final int rate;
  final Uint8List? image; // byte array representation of image

  FriendModel({
    this.id,
    required this.name,
    required this.age,
    required this.number,
    required this.rate,
    this.image,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      age: json["age"] ?? 0,
      number: json['number'] ?? "",
      rate: json["rate"] ?? 0,
      image: json["image"] == null ? null : Uint8List.fromList(json["image"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "number": number,
      "rate": rate,
      "image": image,
    };
  }
}
