import 'package:cuidapet_curso/app/models/provider_detail_model.dart';
import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:cuidapet_curso/app/services/provider_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'provider_controller.g.dart';

@Injectable()
class ProviderController = _ProviderControllerBase with _$ProviderController;

abstract class _ProviderControllerBase with Store {
  final ProviderService _providerService;

  _ProviderControllerBase(this._providerService);

  @observable
  ObservableFuture<ProviderDetailModel> providerFuture;
  @observable
  ObservableFuture<List<ServiceModel>> servicesFuture;

  @action
  void initPage(int providerId) {
    getProviderDetail(providerId);
    getProviderServices(providerId);
  }

  @action
  void getProviderDetail(int providerId) {
    providerFuture =
        ObservableFuture(_providerService.searchProviderDetail(providerId));
  }

  @action
  void getProviderServices(int providerId) {
    servicesFuture =
        ObservableFuture(_providerService.searchProviderServices(providerId));
  }
}
