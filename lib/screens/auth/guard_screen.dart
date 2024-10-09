import 'package:flutter/material.dart';
import 'package:grad_project/screens/auth/login_screen.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({Key? key}) : super(key: key);

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60,),
          Center(

            child: Image.asset(
              'images/family.jpeg',
              width: 350,
              height: 350,
            ),
          ),
          const SizedBox(height: 20,),
          const Center(
            child: Text(
              'Login as a ..',
              style: TextStyle(color: Color(0xff415380), fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        isUser: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xff415380),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'User',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        isUser: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xff415380),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Doctor',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
