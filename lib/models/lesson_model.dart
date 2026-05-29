class Exercise {
  final String id;
  final String type; // 'mcq', 'fillblank', 'truefalse', 'arrange'
  final String questionBM;
  final String questionEN;
  final List<String> options; // for mcq/arrange
  final String correctAnswer; // index as string for mcq, answer text for others
  final String? codeSample; // code snippet if needed
  final String explanationBM;
  final String explanationEN;

  const Exercise({
    required this.id,
    required this.type,
    required this.questionBM,
    required this.questionEN,
    required this.options,
    required this.correctAnswer,
    this.codeSample,
    required this.explanationBM,
    required this.explanationEN,
  });
}

class Lesson {
  final String id;
  final String unitId;
  final String titleBM;
  final String titleEN;
  final String descBM;
  final String descEN;
  final String emoji;
  final List<Exercise> exercises;
  final int xpReward;

  const Lesson({
    required this.id,
    required this.unitId,
    required this.titleBM,
    required this.titleEN,
    required this.descBM,
    required this.descEN,
    required this.emoji,
    required this.exercises,
    this.xpReward = 20,
  });
}

class Unit {
  final String id;
  final String titleBM;
  final String titleEN;
  final String emoji;
  final String color; // hex color e.g. '#4CAF50'
  final List<Lesson> lessons;

  const Unit({
    required this.id,
    required this.titleBM,
    required this.titleEN,
    required this.emoji,
    required this.color,
    required this.lessons,
  });
}
