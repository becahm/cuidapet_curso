import 'package:cuidapet_curso/app/models/category_model.dart';
import 'package:cuidapet_curso/app/repository/categories_repository.dart';

class CategoriesService {
  final CategoriesRepository _repository;
  CategoriesService(
    this._repository,
  );

  Future<List<CategoryModel>> getCategories() {
    return _repository.searchCategories();
  }
}
