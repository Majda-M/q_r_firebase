class Question{
  String questionText;
  bool isCorrect;

  Question({required this.questionText,required this.isCorrect});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionText: json['questionText'],
    isCorrect: json['isCorrect'],
  );
  Map<String, dynamic> toJson() => {
    'questionText': questionText,
    'isCorrect': isCorrect,
  };
}