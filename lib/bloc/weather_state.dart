part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}


final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  const WeatherSuccess(this.weather);
}

class WeatherFailure extends WeatherState {
  final String error;

  const WeatherFailure(this.error);
}
