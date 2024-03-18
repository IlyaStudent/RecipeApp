import 'package:project/models/recepie.dart';
import 'package:project/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recepie>?> getRecepies(String filter) async {
    String path = "https://dummyjson.com/recipes/";
    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      List<Recepie> recipes = data.map((e) => Recepie.fromJson(e)).toList();
      print(recipes);
      return recipes;
    }
  }
}
