import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection/injection_container.dart' as di;
import 'domain/repositories/bloc/weather_bloc.dart';
import 'presentation/pages/weather_page.dart';
import 'domain/repositories/bloc/weather_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: BlocProvider(
        create: (context) => di.sl<WeatherBloc>()..add(const LoadWeatherData()),
        child: const WeatherPage(),
      ),
    );
  }
}
