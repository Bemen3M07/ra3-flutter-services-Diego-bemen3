// lib/controller/joke_controller.dart
import '../model/joke_model.dart';

class JokeController {
  final JokeModel _model = JokeModel();

  Future<Joke> getNewJoke() {
    return _model.fetchRandomJoke();
  }
}