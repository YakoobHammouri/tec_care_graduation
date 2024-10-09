import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/firebase_response.dart';
import 'package:grad_project/models/person.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  String? _emailError;
  String? _passwordError;
  String? _nameError;
  String? _heightError;
  String? _weightError;
  String? _ageError;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _nameTextController;

  // late TextEditingController _dateTextController;
  late TextEditingController _heightTextController;
  late TextEditingController _weightTextController;
  late TextEditingController _ageTextController;

  @override
  void initState() {
    // TODO: implement initState
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _nameTextController = TextEditingController();
    // _dateTextController = TextEditingController();
    _heightTextController = TextEditingController();
    _weightTextController = TextEditingController();
    _ageTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
    // _dateTextController.dispose();
    _heightTextController.dispose();
    _weightTextController.dispose();
    _ageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 60,
                top: 20,
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                keyboardType: TextInputType.name,
                controller: _nameTextController,
                decoration: InputDecoration(
                  errorText: _nameError,
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Full name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                controller: _ageTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range),
                  hintText: 'Age',
                  errorText: _ageError,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                controller: _heightTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.height),
                  hintText: 'Height',
                  errorText: _heightError,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                controller: _weightTextController,
                decoration: InputDecoration(
                  errorText: _weightError,
                  prefixIcon: const Icon(Icons.monitor_weight_outlined),
                  hintText: 'Weight',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailTextController,
                decoration: InputDecoration(
                  errorText: _emailError,
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: _passwordError,
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 39, left: 60),
              width: 300,
              height: 53,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff415380),
                ),
                onPressed: () async {
                  await performRegister();
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Text('Do you have an account?'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) await register();
  }

  Future<void> register() async {
    // FirebaseResponse response = await FbAuthController().createAccount(
    //     email: _emailTextController.text,
    //     password: _passwordTextController.text,
    //     name: _nameTextController.text);
    FirebaseResponse response = await FbAuthController().createAccount(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        name: _nameTextController.text);
    Person person = Person();
    person.id = response.credential!.user!.uid;
    person.name = _nameTextController.text;
    person.height = int.parse(_heightTextController.text);
    person.weight = int.parse(_weightTextController.text);
    person.email = _emailTextController.text;
    person.age = int.parse(_ageTextController.text);
    // person.dateOfBirth = DateTime.parse(_dateTextController.text);
    Future<bool> fireStoreResult = FbFireStoreController()
        .createUser(person)
        .then((value) => true)
        .catchError((e) => false);
    String fireStoreResponse = fireStoreResult.toString();
    if (response.credential != null && fireStoreResponse == 'true') {
      Navigator.pop(context);
      clearData();
      showSnackBar(context: context, message: "User created successfully");
    } else {
      showSnackBar(
          context: context,
          message: response.message,
          error: !response.success);
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _nameTextController.text.isNotEmpty &&
        _heightTextController.text.isNotEmpty &&
        _weightTextController.text.isNotEmpty &&
        _ageTextController.text.isNotEmpty) {
      controlError();
      return true;
    }
    controlError();
    showSnackBar(
        context: context, message: "Enter required data!", error: true);
    return false;
  }

  void controlError() {
    setState(() {
      _emailError = _emailTextController.text.isEmpty
          ? 'Enter email address, Please!'
          : null;
      _passwordError = _passwordTextController.text.isEmpty
          ? 'Enter password, Please!'
          : null;
      _nameError =
          _nameTextController.text.isEmpty ? 'Enter username, Please!' : null;
      _ageError =
          _ageTextController.text.isEmpty ? 'Enter your age, please!' : null;
      _weightError = _weightTextController.text.isEmpty
          ? 'Enter your weight, please!'
          : null;
      _heightError = _heightTextController.text.isEmpty
          ? 'Enter your height, please!'
          : null;
    });
  }

  void clearData() {
    _emailTextController.text = '';
    _nameTextController.text = '';
    _passwordTextController.text = '';
    _heightTextController.text = '';
    _weightTextController.text = '';
  }
}
