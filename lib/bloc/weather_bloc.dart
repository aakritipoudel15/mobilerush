import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_rush/model/weather.model.dart';
import 'package:mobile_rush/service/weatherservice.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherLoading()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherService.fetchWeather();
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherFailure(e.toString()));
      }
    });
  }
}
