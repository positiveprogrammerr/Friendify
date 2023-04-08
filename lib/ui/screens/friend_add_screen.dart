// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'dart:convert';
import 'dart:io';
import 'package:database_app/data/model/friend_model.dart';
import 'package:database_app/ui/screens/all_friends_page.dart';
import 'package:database_app/view_model/friends_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File _imageFile = File('');
  bool isImage = false;

  @override
  Widget build(BuildContext context) {
    final isImageColor = Provider.of<FriendViewModel>(context).imageNum;
    Color _changer = isImageColor? const Color.fromARGB(255, 14, 49, 79):const Color.fromARGB(255, 109, 9, 59);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:_changer,
        title:  Text('Add Friend',style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,fontSize: 24),),
        centerTitle: true,
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
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null && pickedFile.path.isNotEmpty) {
                        setState(() {
                          isImage = true;
                          _imageFile = File(pickedFile.path);
                        });
                      }
                    },
                    child: isImage
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: FileImage(_imageFile),
                                fit: BoxFit.cover,
                                colorFilter: isImage
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
                   focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: _changer ,width: 1.6)),
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
                  controller: _numberController,
                  decoration: InputDecoration(
                    hintText: 'Enter contact number',
                      border: const OutlineInputBorder(),
                   focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: _changer ,width: 1.6)),
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
                  decoration:  InputDecoration(
                    hintText: 'Enter age',
                       border: const OutlineInputBorder(),
                   focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: _changer ,width: 1.6)),
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
                  decoration:  InputDecoration(
                    hintText: 'Enter rate',
                       border: const OutlineInputBorder(),
                   focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: _changer ,width: 1.6)),
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
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final name = _nameController.text;
                        final contactNumber = _numberController.text;
                        final age = int.tryParse(_ageController.text) ?? 0;
                        final rate = int.tryParse(_rateController.text) ?? 0;
                        if (_imageFile.path.isEmpty) {
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
                        final bytes = await _imageFile.readAsBytes();
                        final image = base64Encode(bytes);

                        final newFriend = FriendModel(
                          name: name,
                          number: contactNumber,
                          age: age,
                          rate: rate,
                          image: image.isNotEmpty ? base64Decode(image) : null,
                        );
                        context.read<FriendViewModel>().addFriend(newFriend);
                        context.read<FriendViewModel>().readFriend();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FriendsShowPage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(360, 53),
                      foregroundColor: Colors.white,
                      backgroundColor:
                         isImageColor
                              ? const Color.fromARGB(255, 14, 49, 79)
                              : const Color.fromARGB(255, 109, 9, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      'Add Friend  😎',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: GoogleFonts.lato().fontFamily),
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
