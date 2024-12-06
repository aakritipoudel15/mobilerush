class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String condition;
  final int riskFactor;
  final int precipitationProbability;
  final double windSpeed;
  final String windDirection;
  final int atmPressure;
  final double humidity;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.riskFactor,
    required this.precipitationProbability,
    required this.windSpeed,
    required this.windDirection,
    required this.atmPressure,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['city'],
      temperature: (json['weather']['temperature'] as num).toDouble(),
      feelsLike: (json['weather']['feels_like'] as num).toDouble(),
      condition: json['weather']['condition'],
      riskFactor: json['weather']['risk_factor'],
      precipitationProbability: json['weather']['precipitation_probability'],
      windSpeed: (json['weather']['wind_speed'] as num).toDouble(),
      windDirection: json['weather']['wind_direction'],
      atmPressure: json['weather']['atm_pressure'],
      humidity: (json['weather']['humidity'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': {
        'city': cityName,
      },
      'weather': {
        'temperature': temperature,
        'feels_like': feelsLike,
        'condition': condition,
        'risk_factor': riskFactor,
        'precipitation_probability': precipitationProbability,
        'wind_speed': windSpeed,
        'wind_direction': windDirection,
        'atm_pressure': atmPressure,
        'humidity': humidity,
      },
    };
  }
}
