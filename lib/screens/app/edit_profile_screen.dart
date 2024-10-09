import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/person.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _weightTextController;
  late TextEditingController _heightTextController;
  late TextEditingController _ageTextController;

  String nameText = '';
  String weightText = '';
  String heightText = '';
  String ageText = '';

  // late TextEditingController _nameTextController;

  @override
  void initState() {
    super.initState();
    _getdata();
    // _nameTextController.text = nameText;
    _nameTextController = TextEditingController();
    _heightTextController = TextEditingController();
    _weightTextController = TextEditingController();
    _ageTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _heightTextController.dispose();
    _weightTextController.dispose();
    _ageTextController.dispose();
    super.dispose();
  }

  User user = FbAuthController().user;
  @override
  Widget build(BuildContext context) {
    _nameTextController.text = nameText;
    _weightTextController.text = weightText;
    _heightTextController.text = heightText;
    _ageTextController.text = ageText;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xff415380),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff415380),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Color(0xff415380),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 45,
            ),
            child: Text(
              "Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 15,
            ),
            child: TextField(
              controller: _nameTextController,
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: _nameTextController.text,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 45,
            ),
            child: Text(
              "Age",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: TextField(
              controller: _ageTextController,
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: 'Height',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 45,
            ),
            child: Text(
              "Weight",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: TextField(
              controller: _weightTextController,
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: '_nameTextController.text!',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 45,
            ),
            child: Text(
              "Height",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: TextField(
              controller: _heightTextController,
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: 'Height',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await performUpdate();
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 29, left: 0),
                width: 290,
                height: 53,
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff415380),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getdata() async {
    User user = FbAuthController().user;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        nameText = userData.data()!['name'];
        weightText = userData.data()!['weight'].toString();
        heightText = userData.data()!['height'].toString();
        ageText = userData.data()!['age'].toString();
      });
    });
  }

  Future<void> performUpdate() async {
    Person person = Person();
    person.id = user.uid;
    person.email = user.email!;
    person.name = _nameTextController.text;
    person.weight = int.parse(_weightTextController.text);
    person.height = int.parse(_heightTextController.text);
    person.age = int.parse(_ageTextController.text);

    bool fireStoreResult = await FbFireStoreController().updateUser(person);

    String fireStoreResponse = fireStoreResult.toString();
    print(fireStoreResponse);
    if (fireStoreResponse == 'true') {
      showSnackBar(context: context, message: "User updated successfully");
      Navigator.pop(context);
    } else {
      showSnackBar(
          context: context,
          message: "Update failed. Please, try again!",
          error: true);
    }
  }
}
