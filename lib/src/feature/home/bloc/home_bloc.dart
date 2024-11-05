import 'package:bloc/bloc.dart';
import 'package:dynasty_dive/src/core/dependency_injection.dart';
import 'package:dynasty_dive/src/feature/home/models/daily.dart';
import 'package:dynasty_dive/src/feature/home/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository = locator<HomeRepository>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      final List<Daily> dailies = await repository.loadDaily();
      emit(HomeLoadedState(dailies[DateTime.now().weekday - 1]));
    });
  }
}
