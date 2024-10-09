import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/models/exercise.dart';
import 'package:grad_project/screens/app/home_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({required this.exercise, required this.isDoctor, Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
  Exercise exercise;
  bool isDoctor;
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _counter = 0;
  int _burnt = 0;
  late YoutubePlayerController _youtubePlayerController;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.exercise.urlVideo)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _youtubePlayerController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
      ),
      builder: (context, player) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              widget.exercise.name,
              style: const TextStyle(
                color: Color(0XFF415380),
                fontWeight: FontWeight.bold,
                fontSize: 22,
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
                ListTile(
                  // onTap: () => Navigator.pop(context),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(user: FbAuthController().user, isDoctor: widget.isDoctor,),
                      ),
                    );
                  },
                  leading: const Icon(
                    Icons.home,
                    color: Color(0XFF415380),
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.isDoctor,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile_screen');
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
          body: ListView(
            children: [
              player,
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exercise.description,
                      style: const TextStyle(
                        color: Color(0XFF415380),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'A round of 30 mins burns ' +
                          widget.exercise.burntCalories.toString() +
                          ' calories.',
                      style: const TextStyle(
                        color: Color(0XFF415380),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _counter = 0;
                        _burnt = 0;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff415380),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Icon(
                              Icons.lock_reset_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Reset',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff415380),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _counter.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ++_counter;
                        _burnt += widget.exercise.burntCalories;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff415380),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: const [
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Center(
                            child: Text(
                              'Plus',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _burnt != 0,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 120,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'You burnt ' + _burnt.toString() + ' calories.',
                        style: const TextStyle(
                          color: Color(0XFF415380),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
