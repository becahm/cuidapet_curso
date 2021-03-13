import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/provider_detail_model.dart';
import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/models/service_model.dart';

class ProviderRepository {
  Future<List<ProviderSearchModel>> getProviders(double lat, double long) {
    return CustomDio.authInstance.get('/fornecedores', queryParameters: {
      'lat': lat,
      'long': long
    }).then((value) => value.data
        .map<ProviderSearchModel>((p) => ProviderSearchModel.fromJson(p))
        .toList());
  }

  Future<ProviderDetailModel> getProviderDetail(int providerId) async {
    return CustomDio.authInstance
        .get('/fornecedores/$providerId')
        .then((p) => ProviderDetailModel.fromJson(p.data));
  }

  Future<List<ServiceModel>> getProviderServices(int providerId) async {
    return CustomDio.authInstance
        .get('/fornecedores/servicos/$providerId')
        .then((value) => value.data
            .map<ServiceModel>((p) => ServiceModel.fromJson(p))
            .toList());
  }
}
