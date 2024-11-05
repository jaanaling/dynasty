import 'package:dynasty_dive/src/core/utils/json_loader.dart';
import 'package:dynasty_dive/src/feature/home/models/daily.dart';

class HomeRepository {
  Future<List<Daily>> loadDaily() {
    return JsonLoader.loadData<Daily>(
      'daily',
      'assets/json/daily.json',
      (json) => Daily.fromMap(json),
    );
  }
}
