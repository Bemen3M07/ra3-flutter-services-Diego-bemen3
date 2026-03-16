// lib/view/joke_view.dart
import 'package:flutter/material.dart';
import '../controller/joke_controller.dart';
import '../model/joke_model.dart';

class JokeView extends StatefulWidget {
  const JokeView({super.key});

  @override
  State<JokeView> createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  final JokeController _controller = JokeController();
  Joke? _joke;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  Future<void> _loadJoke() async {
    setState(() => _loading = true);
    final joke = await _controller.getNewJoke();
    setState(() {
      _joke = joke;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Joke Aleatorio')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _joke!.setup,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _joke!.punchline,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _loadJoke,
                      child: const Text('Nueva joke'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}