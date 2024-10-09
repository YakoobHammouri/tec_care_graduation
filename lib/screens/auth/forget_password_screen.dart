import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/firebase_response.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  late TextEditingController _emailTextController;
  String? _emailError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              // width: 20,
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                "Find your account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 40),
              width: 300,
              height: 53,
              child: const Text(
                'Enter your email, please. We will send you a verification link to get your account back!',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 40, bottom: 20),
              width: 300,
              child: TextField(
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
              margin: const EdgeInsets.only(top: 20, left: 40),
              width: 300,
              height: 53,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff415380),
                ),
                onPressed: () => performPasswordReset(),
                child: const Text(
                  'Send verification code',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              // width: 20,
              height: 32,
            ),
            const Center(
              child: Text(
                "Or",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 65),
              width: 300,
              height: 53,
              child: Row(
                children: [
                  const Text(
                    'Create a new account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/register_screen'),
                    child: const Text(
                      'Sign up!',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performPasswordReset() async {
    if (checkData()) await passwordReset();
  }

  Future<void> passwordReset() async {
    FirebaseResponse response = await FbAuthController()
        .forgetPassword(email: _emailTextController.text);
    if (response.success) {
      Navigator.pop(context);
      showSnackBar(context: context, message: response.message);
    } else {
      showSnackBar(
          context: context,
          message: response.message,
          error: !response.success);
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty) {
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
    });
  }
}
