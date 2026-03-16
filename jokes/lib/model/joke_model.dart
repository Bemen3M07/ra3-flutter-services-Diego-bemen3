// lib/model/joke_model.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class Joke {
  final String setup;
  final String punchline;

  Joke({required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }
}

class JokeModel {
  final String apiUrl = 'https://api.sampleapis.com/jokes/goodJokes';

  Future<Joke> fetchRandomJoke() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List jokes = json.decode(response.body);
      final random = Random().nextInt(jokes.length);
      return Joke.fromJson(jokes[random]);
    } else {
      throw Exception('Error carregant acudits');
    }
  }
}