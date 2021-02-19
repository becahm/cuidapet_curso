import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/provider_search_model.dart';

class ProviderRepository {
  Future<List<ProviderSearchModel>> searchProviders(double lat, double long) {
    return CustomDio.authInstance.get('/fornecedores', queryParameters: {
      'lat': lat,
      'long': long
    }).then((value) => value.data
        .map<ProviderSearchModel>((p) => ProviderSearchModel.fromJson(p))
        .toList());
  }
}
