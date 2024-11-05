import 'package:dynasty_dive/src/core/utils/json_loader.dart';
import 'package:dynasty_dive/src/feature/notions/models/notion.dart';

class NotionRepository {
  Future<List<Notion>> loadNotion() {
    return JsonLoader.loadData<Notion>(
      'notion',
      '',
      (json) => Notion.fromMap(json),
    );
  }

  Future<void> updateNotion(Notion updatedNotion) async {
    return JsonLoader.modifyDataList<Notion>(
      'notion',
      updatedNotion,
      () async => await loadNotion(),
      (notion) => notion.toMap(),
      (itemList) async {
        final index = itemList.indexWhere((d) => d.id == updatedNotion.id);
        if (index != -1) {
          itemList[index] = updatedNotion;
        }
      },
    );
  }

  Future<void> saveDiary(Notion notion) {
    return JsonLoader.saveData<Notion>(
      'notion',
      notion,
      () async => await loadNotion(),
      (notion) => notion.toMap(),
    );
  }

  Future<void> removeDiary(Notion notion) {
    return JsonLoader.removeData<Notion>(
      'notion',
      notion,
      () async => await loadNotion(),
      (notion) => notion.toMap(),
    );
  }
}
