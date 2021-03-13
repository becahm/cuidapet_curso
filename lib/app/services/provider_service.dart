import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/models/provider_detail_model.dart';
import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:cuidapet_curso/app/repository/provider_repository.dart';

class ProviderService {
  final ProviderRepository _repository;
  ProviderService(
    this._repository,
  );

  Future<List<ProviderSearchModel>> searchProviders(AddressModel address) {
    return _repository.getProviders(address.latitude, address.longitude);
  }

  Future<ProviderDetailModel> searchProviderDetail(int providerId) {
    return _repository.getProviderDetail(providerId);
  }

  Future<List<ServiceModel>> searchProviderServices(int providerId) {
    return _repository.getProviderServices(providerId);
  }
}
