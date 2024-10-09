import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/models/exercise.dart';
import 'package:grad_project/models/person.dart';

class FbFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static FbFireStoreController? _instance;

  FbFireStoreController._();

  factory FbFireStoreController() {
    return _instance ??= FbFireStoreController._();
  }

  //Create User Method
  Future<bool> createUser(Person person) {
    return _fireStore
        .collection('users')
        .doc(person.id)
        .set(person.toMap())
        .then((value) => true)
        .catchError((e) => false);
  }

  // Update User Method
  Future<bool> updateUser(Person person) {
    return _fireStore
        .collection('users')
        .doc(person.id)
        .update(person.toMap())
        .then((value) => true)
        .catchError((e) => false);
  }

  Stream<QuerySnapshot<Person>> readUsers() async* {
    yield* _fireStore
        .collection('users')
        .withConverter<Person>(
          fromFirestore: (snapshot, options) =>
              Person.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots();
  }

  // Read method
  Stream<QuerySnapshot<Exercise>> readExercises() async* {
    yield* _fireStore
        .collection('exercises')
        .withConverter<Exercise>(
          fromFirestore: (snapshot, options) =>
              Exercise.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots();
  }

  Future<bool> doesDoctorExist(String email) async {
    try {
      return await _fireStore
          .collection('doctors')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.size > 0 ? true : false)
          .catchError((e) => false);
    } catch (e) {
      return Future(() => false);
    }
  }

  Future<bool> isDoctor(String email) async =>
      await FbFireStoreController().doesDoctorExist(email);
}
