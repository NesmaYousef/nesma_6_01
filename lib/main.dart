import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  return runApp(
    Phoenix(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> choices = ['paper_btn', 'rock_btn', 'scisor_btn'];
  List<String> emojis = ['👍', '👎', '🤝']; // List of emojis to display
  List<String> displayedEmojis = []; // List to store displayed emojis
  late String resultEmoji = '';
  late String user;
  late String system;
  late int score;
  late int duration;

  void changeChoice() {
    setState(() {
      user = choices[Random().nextInt(3)];
      system = choices[Random().nextInt(3)];
      duration++;
      if (duration == 12) {
        _showMyDialog();
      }
      if (displayedEmojis.length < 12) {
        displayedEmojis.add(resultEmoji);
      }
      print(user);
      print(system);
    });
  }

  void game() {
    if (user == 'paper_btn' && system == 'paper_btn') {
      resultEmoji = emojis[2];
      print("result is equal");
    }
    if (user == 'paper_btn' && system == 'rock_btn') {
      resultEmoji = emojis[0];
      print("result is win");
      score++;
      print(score);
    }
    if (user == 'paper_btn' && system == 'scisor_btn') {
      resultEmoji = emojis[1];
      print("result is loss");
    }
    if (user == 'rock_btn' && system == 'paper_btn') {
      resultEmoji = emojis[1];
      print("result is loss");
    }
    if (user == 'rock_btn' && system == 'rock_btn') {
      resultEmoji = emojis[2];
      print("result is equal");
    }
    if (user == 'rock_btn' && system == 'scisor_btn') {
      resultEmoji = emojis[0];
      print("result is win");
      score++;
      print(score);
    }
    if (user == 'scisor_btn' && system == 'paper_btn') {
      resultEmoji = emojis[0];
      print("result is win");
      score++;
      print(score);
    }
    if (user == 'scisor_btn' && system == 'rock_btn') {
      resultEmoji = emojis[1];
      print("result is loss");
    }
    if (user == 'scisor_btn' && system == 'scisor_btn') {
      resultEmoji = emojis[2];
      print("result is equal");
    }
  }

  @override
  void initState() {
    user = choices[0];
    system = choices[0];
    score = 0;
    duration = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rock Paper Scissors',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF060A47),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'score: $score',
              style: TextStyle(color: Colors.white),
            ),
            // iterates through the displayedEmojis list,
            // converts each emoji into a Text widget,
            // and then converts the resulting sequence of Text widgets into a new list.

            Padding(
              padding: EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: displayedEmojis
                      .map((emoji) => Text(
                            emoji,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        child: TextButton(
                            onPressed: () {
                              game();
                              changeChoice();
                            },
                            child: Image.asset('assets/images/$user.png')),
                      ),
                      Text(
                        'You',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  'VS',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Image.asset('assets/images/$system.png'),
                      ),
                      Text(
                        'System',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset(
            'assets/images/close.png',
            height: 100,
            width: 100,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  children: [
                    Text('END GAME'),
                    Text('YOUR SCORE IS $score/$duration'),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                child: Center(child: const Text('PLAY AGAIN')),
                onPressed: () {
                  Phoenix.rebirth(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
