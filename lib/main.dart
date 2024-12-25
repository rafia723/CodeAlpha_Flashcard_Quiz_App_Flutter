import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './providers/flashcard_provider.dart';

void main() {
  runApp(const FlashcardQuizApp());
}

class FlashcardQuizApp extends StatelessWidget {
  const FlashcardQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashcardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flashcard Quiz App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
