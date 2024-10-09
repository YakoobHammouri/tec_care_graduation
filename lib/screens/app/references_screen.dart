import 'package:flutter/material.dart';

class ReferencesScreen extends StatelessWidget {
  const ReferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Reference Links',
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
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            width: 380,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                const Text(
                  "Demo Link",
                  style: TextStyle(fontSize: 18, color: Color(0XFF415380)),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.link,
                      color: Color(0XFF415380),
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            width: 380,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                const Text(
                  "Demo Link",
                  style: TextStyle(fontSize: 18, color: Color(0XFF415380)),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.link,
                      color: Color(0XFF415380),
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
            width: 380,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                const Text(
                  "Demo Link",
                  style: TextStyle(fontSize: 18, color: Color(0XFF415380)),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.link,
                      color: Color(0XFF415380),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
