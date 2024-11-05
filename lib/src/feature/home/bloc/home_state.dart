part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState {
  final Daily daily;
  const HomeLoadedState(this.daily);

  @override
  List<Object> get props => [daily];
}