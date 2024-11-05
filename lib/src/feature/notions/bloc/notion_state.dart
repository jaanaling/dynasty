part of 'notion_bloc.dart';

abstract class NotionState extends Equatable {
  const NotionState();

  @override
  List<Object?> get props => [];
}

class NotionInitial extends NotionState {}

class NotionLoading extends NotionState {}

class NotionLoaded extends NotionState {
  final List<Notion> notions;

  const NotionLoaded(this.notions);

  @override
  List<Object?> get props => [notions];
}

class NotionError extends NotionState {
  final String message;

  const NotionError(this.message);

  @override
  List<Object?> get props => [message];
}