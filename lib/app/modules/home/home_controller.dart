import 'package:cuidapet_curso/app/models/category_model.dart';
import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/services/provider_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/modules/home/addresses/addresses_module.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/services/address_service.dart';
import 'package:cuidapet_curso/app/services/categories_service.dart';
part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  AddressService _addressService;
  CategoriesService _categoryService;
  ProviderService _providerService;

  @observable
  AddressModel selectedAddress;

  @observable
  ObservableFuture<List<CategoryModel>> categoriesFuture;

  @observable
  int selectedPage = 0;

  @observable
  ObservableFuture<List<ProviderSearchModel>> providersFuture;

  _HomeControllerBase(
    this._addressService,
    this._categoryService,
    this._providerService,
  );

  @action
  void changeSelectedPage(int page) => selectedPage = page;

  @action
  Future<void> initPage() async {
    await verifyIfHasAddress();
    await getSelectedAddress();
    getCategories();
    getProviders();
  }

  @action
  Future<void> verifyIfHasAddress() async {
    var hasAddress = await _addressService.hasRegisteredAdress();
    if (!hasAddress) {
      await Modular.link.pushNamed(AddressesModule.route);
    }
  }

  @action
  Future<void> getSelectedAddress() async {
    final prefs = await SharedPrefsRepository.instance;
    selectedAddress = prefs.selectedAddress;
  }

  @action
  void getCategories() {
    categoriesFuture = ObservableFuture(_categoryService.getCategories());
  }

  @action
  void getProviders() {
    providersFuture =
        ObservableFuture(_providerService.searchProviders(selectedAddress));
  }
}
