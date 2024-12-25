import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  final List<Flashcard> _flashcards = [];
  int _score = 0;

  List<Flashcard> get flashcards => _flashcards;
  int get score => _score;

  void addFlashcard(String question, String answer) {
    _flashcards.add(Flashcard(question: question, answer: answer));
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  void incrementScore() {
    _score++;
    notifyListeners();
  }
}
