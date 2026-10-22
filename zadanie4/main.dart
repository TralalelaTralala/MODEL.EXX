import 'dart:async';
import 'dart:math';

/// Імітує асинхронне отримання поточної погоди для міста.
class WeatherService {
  final Random _random;

  WeatherService({Random? random}) : _random = random ?? Random();

  /// Повертає дані погоди через 1–2 секунди.
  /// Порожня назва міста вважається помилкою.
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final normalizedCity = city.trim();
    if (normalizedCity.isEmpty) {
      throw ArgumentError('Місто не вказано');
    }

    await Future<void>.delayed(
      Duration(seconds: 1 + _random.nextInt(2)),
    );

    final temperature = -10 + _random.nextInt(46); // від -10 до 35 °C
    final conditions = <String>[
      'сонячно',
      'хмарно',
      'дощ',
      'сніг',
      'вітряно',
    ];

    return <String, dynamic>{
      'city': normalizedCity,
      'temp': temperature,
      'condition': conditions[_random.nextInt(conditions.length)],
    };
  }

  /// Щосекунди видає випадкову температуру; після [times] значень завершується.
  Stream<int> temperatureUpdates({int times = 5}) async* {
    if (times <= 0) return;

    for (var i = 0; i < times; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield -10 + _random.nextInt(46); // від -10 до 35 °C
    }
  }
}

/// Приклад використання обох асинхронних методів.
Future<void> main() async {
  final service = WeatherService();

  try {
    final weather = await service.fetchCurrentWeather('Київ');
    print(weather);
  } on ArgumentError catch (error) {
    print('Помилка: $error');
  } catch (error) {
    print('Не вдалося отримати погоду: $error');
  }

  await for (final temperature in service.temperatureUpdates(times: 3)) {
    print('Температура: $temperature°C');
  }
}
