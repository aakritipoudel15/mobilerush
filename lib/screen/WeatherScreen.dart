import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4169E1), Color(0xFF87CEEB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kathmandu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '40°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Image.asset('assets/sun.png', width: 32.0, height: 32.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Sunny',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeatherDetail('assets/Kathmandu.png', '27%', 'Precipitation'),
                    _buildWeatherDetail('assets/Kathmandu.png', '27 km/hr', 'Wind speed'),
                    _buildWeatherDetail('assets/Kathmandu.png', '35%', 'Humidity'),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Feels Like 42°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Extremely Sunny: Apply Sunscreen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String imagePath, String value, String title) {
    return Column(
      children: [
        Image.asset(imagePath, width: 32.0, height: 32.0),
        SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}