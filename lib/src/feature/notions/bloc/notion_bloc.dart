import 'package:bloc/bloc.dart';
import 'package:dynasty_dive/src/core/dependency_injection.dart';
import 'package:dynasty_dive/src/feature/notions/models/notion.dart';
import 'package:dynasty_dive/src/feature/notions/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'notion_event.dart';
part 'notion_state.dart';

class NotionBloc extends Bloc<NotionEvent, NotionState> {
  final NotionRepository _notionRepository = locator<NotionRepository>();

  NotionBloc() : super(NotionInitial()) {
    on<LoadNotions>(_onLoadNotions);
    on<UpdateNotion>(_onUpdateNotion);
    on<SaveNotion>(_onSaveNotion);
    on<RemoveNotion>(_onRemoveNotion);
  }

  Future<void> _onLoadNotions(LoadNotions event, Emitter<NotionState> emit) async {
    emit(NotionLoading());
    try {
      final notions = await _notionRepository.loadNotion();
      emit(NotionLoaded(notions));
    } catch (e) {
      emit(NotionError("Failed to load notions"));
    }
  }

  Future<void> _onUpdateNotion(UpdateNotion event, Emitter<NotionState> emit) async {
    try {
      await _notionRepository.updateNotion(event.updatedNotion);
      add(LoadNotions()); // Reload the list after update
    } catch (e) {
      emit(NotionError("Failed to update notion"));
    }
  }

  Future<void> _onSaveNotion(SaveNotion event, Emitter<NotionState> emit) async {
    try {
      await _notionRepository.saveDiary(event.notion);
      add(LoadNotions()); // Reload the list after saving
    } catch (e) {
      emit(NotionError("Failed to save notion"));
    }
  }

  Future<void> _onRemoveNotion(RemoveNotion event, Emitter<NotionState> emit) async {
    try {
      await _notionRepository.removeDiary(event.notion);
      add(LoadNotions()); // Reload the list after removal
    } catch (e) {
      emit(NotionError("Failed to remove notion"));
    }
  }
}