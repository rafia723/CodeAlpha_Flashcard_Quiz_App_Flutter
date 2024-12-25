import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  final _answerController = TextEditingController();

  void _nextQuestion(BuildContext context) {
    final provider = Provider.of<FlashcardProvider>(context, listen: false);
    final flashcard = provider.flashcards[_currentIndex];

    String userAnswer = _answerController.text.trim().toLowerCase();
    String correctAnswer = flashcard.answer.trim().toLowerCase();

    if (userAnswer == correctAnswer) {
      provider.incrementScore();
    }

    if (_currentIndex < provider.flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _answerController.clear();
      });
    } else {
      int totalFlashcards = provider.flashcards.length;
      double percentage = (provider.score / totalFlashcards) * 100;

      Navigator.pop(context); // Return to the previous screen
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Quiz Finished!'),
          content: Text(
            'Your score: ${provider.score}/$totalFlashcards\n'
            'Percentage: ${percentage.toStringAsFixed(1)}%',
          ),
          actions: [
            TextButton(
              onPressed: () {
                provider.resetScore();
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardProvider>(context);
    final flashcard = provider.flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black38, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black38, Colors.yellow],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    flashcard.question,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _answerController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Your Answer',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.black38,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _nextQuestion(context),
                child: const Text(
                  'Next Question',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
