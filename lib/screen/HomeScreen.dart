import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_rush/bloc/weather_bloc.dart';
import 'package:mobile_rush/service/weatherservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    weatherBloc = WeatherBloc(WeatherService());
    weatherBloc.add(FetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => weatherBloc,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherSuccess) {
                return _buildWeatherUI(state.weather);
              } else if (state is WeatherFailure) {
                return Center(child: Text('Error: ${state.error}'));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherUI(dynamic weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upper Portion (Dynamic Data)
        _buildUpperWeatherSection(weather),
        const SizedBox(height: 20),

        // Lower Portion (Static Data)
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildRecommendedPlaces(weather.cityName),
              const SizedBox(height: 10),
              _buildRainChancesSection()
            ],
          ),
        ),
      ],
    );
  }

String _getBackgroundImage(String condition) {
  switch (condition.toLowerCase()) {
    case 'sunny':
      return 'assets/sunny.png'; // Use an image for sunny weather
    case 'cloudy':
      return 'assets/cloudy.png'; // Use an image for cloudy weather
    case 'snowy':
      return 'assets/rainy.png'; // Use an image for snowy weather
    default:
      return 'assets/sunny.png'; // Default background
  }
}

  Widget _buildUpperWeatherSection(dynamic weather) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    // decoration: const BoxDecoration(
    //   gradient: LinearGradient(
    //     colors: [ Color.fromARGB(255, 219, 160, 160),  Color.fromARGB(255, 185, 110, 110)],
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //   ),
    // ),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(_getBackgroundImage(weather.condition)), // Use the helper function to get the image based on the weather condition
        fit: BoxFit.cover, // Ensure the image covers the entire container
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 213, 92, 92)),
            ),
            Text(
              '${weather.temperature.toInt()}°C',
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.wb_sunny,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 8),
            Text(
              weather.condition,
              style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 213, 92, 92)),
            ),
          ],
        ),
        const SizedBox(height: 10),
       
        Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  padding: const EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3), // changes the position of the shadow
      ),
    ],
  ),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWeatherDetail(
              'assets/light-rain_3431438.png',
              '${weather.precipitationProbability}%',
              'Precipitation'),
          _buildWeatherDetail('assets/wind_12072090.png',
              '${weather.windSpeed.toInt()} km/h', 'Wind Speed'),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWeatherDetail('assets/humidity_4752084.png',
              '${weather.humidity.toInt()}%', 'Humidity'),
          _buildWeatherDetail('assets/gauge_4157161.png',
              '${weather.atmPressure} mmHg', 'Atm Pressure'),
        ],
      ),
    ],
  ),
),
          const SizedBox(height: 10),
          if (weather.condition == "Sunny" && weather.riskFactor >= 3)
             const Text(
              'Extremely Sunny: Apply Sunscreen',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 213, 92, 92)),
            ),
          if (weather.condition == "Snowy" && weather.riskFactor >= 3)
             const Text(
              'Extremely Snowy: Stay Inside',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 213, 92, 92)),
            ),
          if (weather.condition == "Cloudy" && weather.riskFactor >= 3)
             const Text(
              'Extremely Cloudy: Take Umbrella',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 213, 92, 92)),
            ),
          if (weather.riskFactor < 3)
             Text(
              'Moderate ${weather.condition}',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 213, 92, 92)),
            ),
  
           
      ],
    ),
  );
}

 Widget _buildWeatherDetail(String imagePath, String value, String title) {
    return Column(
      children: [
        Image.asset(imagePath, width: 32.0, height: 32.0),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(
            color: Color.fromARGB(255, 132, 48, 48),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 205, 132, 132),
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}

Widget _buildRecommendedPlaces(String cityName) {
  // Replace with your recommended places logic
  final recommendedPlaces = [
    {'name': 'Kathmandu', 'description': 'City full of temples and monkeys', 'distance': 15},
    {'name': 'Chitwan', 'description': 'Meet the wildlife', 'distance': 50},
    {'name': 'Pokhara', 'description': 'Tourist\'s hub', 'distance': 90},
    {'name': 'Dhangadhi', 'description': 'Beauty of Far-West', 'distance': 185},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Recommended Places',
        style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 185, 70, 70), fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      ...recommendedPlaces.map((place) => _buildRecommendedPlace(place)).toList(),
    ],
  );
}

Widget _buildRecommendedPlace(Map<String, dynamic> place) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/Kathmandu.png'), // Replace with your asset image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place['name']!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                place['description']!,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          '${place['distance']}KM',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}

Widget _buildRainChancesChart(int precipitationProbability) {
  final rainChances = [
    for (int i = 0; i < 7; i++)
      precipitationProbability * (i + 1) ~/ 7,
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Chances of rain',
        style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 185, 70, 70), fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      _buildRainChancesSection(),
    ],
  );
}

Widget _buildRainChancesSection() {
  final List<Map<String, dynamic>> rainData = [
    {'day': 'Sun', 'chance': 20},
    {'day': 'Mon', 'chance': 70},
    {'day': 'Tue', 'chance': 40},
    {'day': 'Wed', 'chance': 80},
    {'day': 'Thu', 'chance': 60},
    {'day': 'Fri', 'chance': 30, 'highlighted': true},
    {'day': 'Sat', 'chance': 50},
  ];

  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chances of Rain',
          style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 185, 70, 70),  fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 120, // Set a fixed height for the bar chart section
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: rainData.map((data) {
              return _buildRainChanceBar(
                data['day'],
                data['chance'],
                isHighlighted: data['highlighted'] ?? false,
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}


Widget _buildRainChanceBar(String day, int chance, {bool isHighlighted = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 10,
            height: 80 * (chance / 100), // Adjust height based on percentage
            decoration: BoxDecoration(
              color: isHighlighted ? Colors.red[300] : Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        day,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    ],
  );
}


