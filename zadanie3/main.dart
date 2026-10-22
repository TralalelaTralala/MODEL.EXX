import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  Future<void> _openDetails() async {
    await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(counter: _counter)),
    );
    // Лічильник не змінюється на екрані деталей, тому після повернення
    // зберігається його поточне значення.
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Головний екран')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Лічильник: $_counter', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _counter++),
                child: const Text('+1'),
              ),
              ElevatedButton(
                onPressed: _openDetails,
                child: const Text('Детальніше'),
              ),
            ],
          ),
        ),
      );
}

class DetailsScreen extends StatelessWidget {
  final int counter;

  const DetailsScreen({super.key, required this.counter});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Деталі')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Передане значення: $counter',
                  style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      );
}
