import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/category_model.dart';

class CategoriesRepository {
  Future<List<CategoryModel>> searchCategories() {
    return CustomDio.authInstance.get('/categorias').then((value) => value.data
        .map<CategoryModel>((c) => CategoryModel.fromJson(c))
        .toList());
  }
}
