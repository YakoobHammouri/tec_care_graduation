import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contact Us',
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
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/home_screen');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              padding: const EdgeInsets.only(left: 25),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xff415380),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/facebook.png",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  const Text(
                    'Facebook',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              padding: const EdgeInsets.only(left: 25),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xff415380),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/instagram.png",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  const Text(
                    'Instagram',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              padding: const EdgeInsets.only(left: 25),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xff415380),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/whatsapp.png",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  const Text(
                    'Whatsapp',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
