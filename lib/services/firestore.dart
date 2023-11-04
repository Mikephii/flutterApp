// import "dart:async";
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:buddybrew/services/auth.dart';
// import 'package:buddybrew/services/models.dart';

// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<List<Topic>> getTopics() async {
//     var ref = _db.collection('topics');
//     var snapshot = await ref.get();
//     var data = snapshot.docs.map((doc) => doc.data());
//     var topics = data.map((d) => Topic.fromJson(d));
//     return topics.toList();
//   }

//   Future<Quiz> getQuiz(String quizId) async {
//     var ref = _db.collection('quizzes').doc(quizId);
//     var snapshot = await ref.get();
//     var data = snapshot.data() ?? {};
//     var quiz = Quiz.fromJson(data);
//     return quiz;
//   }

//   Stream<Report> streamReport() {
//     return AuthService().userStream.switchMap((user) {
//       if (user != null) {
//         var ref = _db.collection('reports').doc(user.uid);
//         return ref.snapshots().map((doc) => Report.fromJson(doc.data() ?? {}));
//       } else {
//         return Stream.fromIterable([Report()]);
//       }
//     });
//   }

//   Future<void> updateUserReport(Quiz quiz) {
//     var user = AuthService().user!;
//     var ref = _db.collection('reports').doc(user.uid);

//     var data = {
//       'total': FieldValue.increment(1),
//       'topics': {
//         quiz.topic: FieldValue.arrayUnion([quiz.id])
//       }
//     };

//     return ref.set(data, SetOptions(merge: true));
//   }
// }
