import 'package:cubits/cubits/weather_cubit.dart';
import 'package:cubits/cubits/weather_states.dart';
import 'package:cubits/models/weather.dart';
import 'package:cubits/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(state.weather);
            } else {
              // (state is WeatherError)
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }
}

Widget buildInitialInput() {
  return const Center(
    child: CityInputField(),
  );
}

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Column buildColumnWithData(Weather weather) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(weather.cityName),
      Text(weather.temperatureCelsius.toStringAsFixed(1))
    ],
  );
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        decoration: const InputDecoration(
            labelText: 'Type City', prefixIcon: Icon(Icons.search)),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final cubit = context.read<WeatherCubit>();
    cubit.getWeather(cityName);
  }
}
