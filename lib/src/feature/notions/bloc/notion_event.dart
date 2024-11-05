part of 'notion_bloc.dart';

abstract class NotionEvent extends Equatable {
  const NotionEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotions extends NotionEvent {}

class UpdateNotion extends NotionEvent {
  final Notion updatedNotion;

  const UpdateNotion(this.updatedNotion);

  @override
  List<Object?> get props => [updatedNotion];
}

class SaveNotion extends NotionEvent {
  final Notion notion;

  const SaveNotion(this.notion);

  @override
  List<Object?> get props => [notion];
}

class RemoveNotion extends NotionEvent {
  final Notion notion;

  const RemoveNotion(this.notion);

  @override
  List<Object?> get props => [notion];
}
