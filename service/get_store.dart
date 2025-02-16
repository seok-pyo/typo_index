import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:typo_index/firebase_options.dart';
import 'package:typo_index/service/typography_model.dart';

class GetStore {
  static Future<List<Typographymodel>> getFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    List<Typographymodel> modelList = [];

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('word').get();

    for (var snap in snapshot.docs) {
      modelList.add(
        Typographymodel.fromJson(snap.data() as Map<String, dynamic>),
      );
    }

    return modelList;
  }
}
