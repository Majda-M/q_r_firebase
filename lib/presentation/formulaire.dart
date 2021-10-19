

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_r_firebase/%20business_logic/cubit/quiz.cubit.dart';
import 'package:q_r_firebase/data/model/question.dart';
import 'package:q_r_firebase/data/repositories/firestore.dart';


class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);

  @override
  _FormulaireDTL createState() => _FormulaireDTL();
}

class _FormulaireDTL extends State<Formulaire> {
  get themeTextController => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final questionTextController = TextEditingController();
    final isCorrectController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body:Container(
      color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Text("Ajouter une question de la categorie FRANCE "),
            ),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: questionTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Question ',
                      hintText: 'saisir la question',
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Categorie',
                      hintText: 'FRANCE',
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: isCorrectController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'La reponse',
                      hintText: 'vrai / faux',
                    ),
                  ),
                )),

            Center(
                child: MaterialButton(
                  onPressed: () {
                    String questionText = questionTextController.text;
                    bool isCorrect = false;
                     if(isCorrectController == "vrai"){
                       isCorrect = true;
                     }
                     addQues(questionText, isCorrect);




                    questionTextController.text = "";
                    isCorrectController.text = "";


                    //bloc.add(FetchQuestionsEvent());
                  },
                  child: Text(
                    "Ajouter la question",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey,
                ))
          ],
        ),
      )
    );

  }
  Future<void> addQues(String txt1,bool txt2) async {

    firestore.addQuestion(Question(questionText: txt1, isCorrect: txt2));

  }
}