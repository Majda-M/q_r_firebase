
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:q_r_firebase/data/model/question.dart';

class firestore{
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static Future<List> getQuestions() async {
    List<dynamic> listQuestions = [];
    try{
      QuerySnapshot snapshot = await firebaseFirestore.collection('QUESTIONS').get();
      print(snapshot.docs);
      listQuestions = snapshot.docs.map((e) => e.data()).toList();
      print(listQuestions);
      print(listQuestions.length);

    }catch(er){
      print(er);
    }
    return listQuestions;

  }
  static Future<void> addQuestion(Question question){
     var val =firebaseFirestore.collection("QUESTIONS").add(question.toJson());
     return val;
  }

}




