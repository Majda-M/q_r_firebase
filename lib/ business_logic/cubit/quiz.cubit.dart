import 'package:bloc/bloc.dart';
import 'package:q_r_firebase/data/model/question.dart';

class MyState{
  final bool  responseStatus;
  final int questionIndex;

  MyState(this.responseStatus, this.questionIndex);


}
class QuizCubit extends Cubit<MyState>{
  QuizCubit() : super(MyState(true,0));



  void checkAnswer(bool response,Question question,int length){
    if (response == question.isCorrect) {
      emit(MyState(true, state.questionIndex));
      nextQuestion(length);
    } else {
      emit(MyState(false, state.questionIndex));
    }

  }
  void nextQuestion(int length){
    if (state.questionIndex < length - 1) {
      emit(MyState(state.responseStatus, state.questionIndex + 1));
    } else {
      emit(MyState(state.responseStatus, 0));
    }

  }

}