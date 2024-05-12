import 'base_network.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategories(){
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String getMeals){
    String meals = getMeals.toString();
    return BaseNetwork.get("filter.php?c=$meals");
  }

  Future<Map<String, dynamic>> loadDetailMeal(String getDetailMeal){
    String detail = getDetailMeal.toString();
    return BaseNetwork.get("lookup.php?i=$detail");
  }
}