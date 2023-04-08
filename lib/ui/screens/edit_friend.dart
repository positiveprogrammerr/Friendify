// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:database_app/view_model/friends_view_model.dart';
import '../../data/model/friend_model.dart';

class FriendEditScreen extends StatefulWidget {
  final FriendModel friend;

  const FriendEditScreen({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FriendEditScreenState createState() => _FriendEditScreenState();
}

class _FriendEditScreenState extends State<FriendEditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? _imageString;
  final bool _isImage = false;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.friend.name);
    _ageController = TextEditingController(text: widget.friend.age.toString());
    _rateController =
        TextEditingController(text: widget.friend.rate.toString());
    _contactNumberController =
        TextEditingController(text: widget.friend.number);
    _imageString =
        widget.friend.image != null ? base64Encode(widget.friend.image!) : null;
    super.initState();
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageString = base64Encode(bytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isImageColor = Provider.of<FriendViewModel>(context).imageNum;
    Color _changer = isImageColor
        ? const Color.fromARGB(255, 14, 49, 79)
        : const Color.fromARGB(255, 109, 9, 59);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _changer,
        title: Text(
          'Edit Friend',
          style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _getImage,
                    child: _imageString != null
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: MemoryImage(base64Decode(_imageString!)),
                                fit: BoxFit.cover,
                                colorFilter: _isImage
                                    ? null
                                    : const ColorFilter.mode(
                                        Colors.transparent, BlendMode.color),
                              ),
                            ),
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Name',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _changer, width: 1.6)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (double.tryParse(value) != null ||
                        int.tryParse(value) != null) {
                      return 'Please enter a valid name';
                    }
                    if (value.length == 20) {
                      return 'Max length of Name is 20';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Contact Number',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _contactNumberController,
                  decoration: InputDecoration(
                    hintText: 'Enter contact number',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _changer, width: 1.6)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    }
                    if (value.length != 13) {
                      return 'The phone number should be 12 digits including the country code (+998)';
                    }
                    if (!RegExp(r'^\+998\d{9}$').hasMatch(value)) {
                      return 'Please enter a valid Uzbek phone number starting with +998';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Age',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    hintText: 'Enter age',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _changer, width: 1.6)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    try {
                      final age = int.parse(value);
                      if (age <= 0 || age > 100) {
                        return 'Please enter a valid age';
                      }
                    } catch (e) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Rate',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _rateController,
                  decoration: InputDecoration(
                    hintText: 'Enter rate',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _changer, width: 1.6)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a rate';
                    }
                    final rate = int.tryParse(value);
                    if (rate == null) {
                      return 'Please enter a valid number';
                    }
                    if (rate < 1 || rate > 5) {
                      return 'The rate should be between 1 and 5';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final id = widget.friend.id;
                        final name = _nameController.text;
                        final contactNumber = _contactNumberController.text;
                        final age = int.tryParse(_ageController.text) ?? 0;
                        final rate = int.tryParse(_rateController.text) ?? 0;
                        if (_imageString!.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Missing Image'),
                              content: const Text('Please Select an image.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        final newFriend = FriendModel(
                          id: id,
                          name: name,
                          number: contactNumber,
                          age: age,
                          rate: rate,
                          image: _imageString != null
                              ? base64Decode(_imageString!)
                              : null,
                        );

                        Provider.of<FriendViewModel>(context, listen: false)
                            .updateFriend(newFriend, widget.friend.id!);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(360, 53),
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Provider.of<FriendViewModel>(context).imageNum
                              ? const Color.fromARGB(255, 14, 49, 79)
                              : const Color.fromARGB(255, 109, 9, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      'Update Friend  😎',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: GoogleFonts.oxygen().fontFamily),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
