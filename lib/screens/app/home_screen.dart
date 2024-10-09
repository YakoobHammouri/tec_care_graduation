import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/models/exercise.dart';
import 'package:grad_project/screens/app/exercise_screen.dart';
import 'package:grad_project/screens/app/profile_screen.dart';

import 'chats_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.user, required this.isDoctor, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  User user;
  bool isDoctor;
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _searchTextController;
  final List<String> _muscleName = <String>[
    // 'Pick a body part',
    'back',
    'cardio',
    'chest',
    'lower arms',
    'lower legs',
    'neck',
    'shoulders',
    'upper arms',
    'upper legs',
    'waist'
  ];

  var selectedType;
  User user = FbAuthController().user;

  // bool isDoc=false;
  // void isDoctor() async {
  //   User user = FbAuthController().user;
  //   setState(() async{
  //     isDoc = await FbFireStoreController().doesDoctorExist(user.email.toString());
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    // isDoctor();
    super.initState();
    _searchTextController = TextEditingController();
    // print('==============='+isDoc.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Color(0XFF415380),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (!scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: const Icon(
            Icons.menu,
            color: Color(0XFF415380),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Color(0XFF415380),
            ),
          ),
        ],
      ),
      // Navigator.pushNamed(context, '/home_screen');
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                'images/yoga.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Visibility(
              visible: !widget.isDoctor,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.person,
                  color: Color(0XFF415380),
                ),
                title: const Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatsPage(isDoctor: widget.isDoctor),
                  ),
                );
              },
              leading: const Icon(
                Icons.local_hospital_outlined,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Doctors chat',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/references_screen');
              },
              leading: const Icon(
                Icons.insert_link,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Reference Links',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/contact_screen');
              },
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Connect with us',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await FbAuthController().signOut();
                Navigator.pushReplacementNamed(context, '/guard_screen');
              },
              leading: const Icon(
                Icons.logout,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                    //             fontSize: 14,
                    //             color: Colors.black,
                    //           ),),
                    ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  color: Color(0XFF415380),
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    selectedType = null;
                  });
                },
                tooltip: "Clear filter",
              ),
              const SizedBox(
                width: 20,
              ),
              DropdownButton(
                items: _muscleName
                    .map(
                      (value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color(0XFF415380),
                            fontSize: 18,
                          ),
                        ),
                        value: value,
                      ),
                    )
                    .toList(),
                onChanged: (selected) {
                  setState(
                    () {
                      selectedType = selected;
                    },
                  );
                  // print(selectedType.runtimeType);
                },
                value: selectedType,
                hint: const Text(
                  'Pick a body part',
                  // selectedType == 'None' ? 'Pick a body part' : selectedType!.toString()!,
                  style: TextStyle(
                    color: Color(0XFF415380),
                    fontSize: 20,
                  ),
                ),
                isExpanded: false,
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Exercise>>(
              stream: FbFireStoreController().readExercises(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final muscleName =
                          snapshot.data!.docs[index].data().muscleName;
                      if (selectedType == '' || selectedType == null) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ExerciseScreen(
                                  exercise: snapshot.data!.docs[index].data(),
                                  isDoctor: widget.isDoctor,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            width: 300,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    snapshot.data!.docs[index].data().urlImage,
                                    fit: BoxFit.cover,
                                    width: 140,
                                    height: 140,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                ),
                                // Text(snapshot.data!.docs[index].id),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .name,
                                          style: const TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 220,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .description,
                                          style: const TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 14,
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
                      } else if (selectedType != null &&
                          muscleName
                              .toLowerCase()
                              .contains(selectedType!.toLowerCase())) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ExerciseScreen(
                                  exercise: snapshot.data!.docs[index].data(),
                                  isDoctor: widget.isDoctor,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            width: 300,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  child: Image.network(
                                    snapshot.data!.docs[index].data().urlImage,
                                    fit: BoxFit.cover,
                                    width: 140,
                                    height: 140,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                ),
                                // Text(snapshot.data!.docs[index].id),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 8),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .name,
                                          style: const TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 220,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 4),
                                        child: const Text(
                                          "Circuit training is when you combine and alternate between six to ten exercises to target different muscle groups",
                                          style: TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 14,
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
                      } else {
                        return const Center(
                          child: Text('No Exercises',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 45,
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'NO DATA',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 45,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
