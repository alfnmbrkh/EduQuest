import 'package:flutter/foundation.dart';

import '../data/quiz_data.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  final Map<int, int> _answers = {};
  bool _isFinished = false;

  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isFinished => _isFinished;

  int get totalQuestions => quizQuestions.length;

  double get progress {
    if (totalQuestions == 0) return 0;
    return (_currentQuestionIndex + 1) / totalQuestions;
  }

  int get score {
    int total = 0;

    for (final entry in _answers.entries) {
      if (entry.key >= 0 && entry.key < quizQuestions.length) {
        if (entry.value == quizQuestions[entry.key].correctAnswerIndex) {
          total++;
        }
      }
    }

    return total;
  }

  int? get selectedAnswer => _answers[_currentQuestionIndex];

  Map<int, int> get answers => Map.unmodifiable(_answers);

  void selectAnswer(int answerIndex) {
    if (_isFinished) return;
    if (answerIndex < 0 ||
        answerIndex >= quizQuestions[_currentQuestionIndex].options.length) {
      return;
    }

    _answers[_currentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_isFinished || selectedAnswer == null) return;

    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
    } else {
      _isFinished = true;
    }

    notifyListeners();
  }

  void previousQuestion() {
    if (_isFinished || _currentQuestionIndex == 0) return;

    _currentQuestionIndex--;
    notifyListeners();
  }

  void restartQuiz() {
    _currentQuestionIndex = 0;
    _answers.clear();
    _isFinished = false;
    notifyListeners();
  }
}
