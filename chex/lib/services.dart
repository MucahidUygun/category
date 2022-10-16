import 'package:chex/initNetwork.dart';
import 'package:chex/model.dart';

class Services {
  static Future<List<String>> getCategories() async {
    try {
      var response = await NetworkClient.instance!.dio
          .get('https://dummyjson.com/products/categories');
      List<String> responseList = response.data.cast<String>();
      return responseList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Model> getProducts(String category) async {
    try {
      var response = await NetworkClient.instance!.dio
          .get('https://dummyjson.com/products/category/$category');
      return Model.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());}
  }
}
