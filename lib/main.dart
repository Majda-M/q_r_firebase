import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_r_firebase/data/model/question.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:q_r_firebase/presentation/formulaire.dart';
import ' business_logic/cubit/quiz.cubit.dart';
import 'data/repositories/firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>QuizCubit())
      ],
      child: MaterialApp(
        title: 'Question/Reponse',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          "/":(context)=>QuizCubitPage(),
          '/formulaire' : (context) => Formulaire(),
        },
      ),
    );
  }

}
class QuizCubitPage extends StatelessWidget{

   static List<dynamic> questions=[];
   static List<Question> ques=[];
  int index=0;
  Future<void> readQuestion() async{
    try {
      questions = await firestore.getQuestions();
      questions.forEach((element) {
        print(element);
        ques.add(Question.fromJson(element));

      });
    }catch(er){
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    readQuestion();
    print(questions);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Questions/Response'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200,
                width: 400,
                child: Image.asset('assets/photo.png')
            ),
            BlocBuilder<QuizCubit,MyState>(
              builder: (context,state){
                index=state.questionIndex;
                print(index);
                return Container(
                  height: 150,
                  width: 300,
                  decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),

                  child: Text(ques[index].questionText,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                );
              },
            ),
            Container(
              height: 150,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){ context.read<QuizCubit>().checkAnswer(true, ques[index], ques.length);}, child: Text("VRAI"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),),
                  ElevatedButton(onPressed: (){ context.read<QuizCubit>().checkAnswer(false,ques[index], ques.length);}, child: Text("FAUX"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),),
                  ElevatedButton(onPressed: (){ context.read<QuizCubit>().nextQuestion(questions.length);}, child: Icon(Icons.arrow_forward),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),)
                ],
              ),


            ),
            BlocBuilder<QuizCubit,MyState>(
              builder: (context,state){
                if(state.responseStatus == true)
                  return  Container(
                    child: Text('Reponse correcte'),
                  );
                else
                  return Container(
                    child: Text('Reponse incorrecte'),
                  );
              },

            ),
            Container(
              child: ElevatedButton(onPressed:(){ Navigator.pushNamed(context, '/formulaire');}, child: Text("Ajouter une question"),),


            )


            //

          ],
        ),
      ),


    );
  }

}