import 'package:cubits/models/weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

// ==============================
class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLoaded &&
          runtimeType == other.runtimeType &&
          weather == other.weather;

  @override
  int get hashCode => weather.hashCode;
}

// ==============================
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
