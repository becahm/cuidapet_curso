import 'package:cuidapet_curso/app/models/category_model.dart';
import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/services/provider_service.dart';
import 'package:flutter/widgets.dart';
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
  final AddressService _addressService;
  final CategoriesService _categoryService;
  final ProviderService _providerService;
  final filterTextFieldController = TextEditingController();

  _HomeControllerBase(
    this._addressService,
    this._categoryService,
    this._providerService,
  );

  @observable
  AddressModel selectedAddress;

  @observable
  ObservableFuture<List<CategoryModel>> categoriesFuture;

  @observable
  int selectedPage = 0;

  @observable
  ObservableFuture<List<ProviderSearchModel>> providersFuture;

  List<ProviderSearchModel> providersOriginal;

  @observable
  int selectedCategoryId;

  @action
  void changeSelectedPage(int page) => selectedPage = page;

  @action
  Future<void> initPage() async {
    await verifyIfHasAddress();
    await getSelectedAddress();
    getCategories();
    await getProviders();
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
  Future<void> getProviders() async {
    providersFuture =
        ObservableFuture(_providerService.searchProviders(selectedAddress));

    providersOriginal = await providersFuture;
    selectedCategoryId = null;
    filterTextFieldController.text = '';
    filterTextFieldController.text = '';
  }

  @action
  void filterCategory(int id) {
    if (selectedCategoryId == id) {
      selectedCategoryId = null;
    } else {
      selectedCategoryId = id;
    }
    _filterProviders();
  }

  @action
  void filterByName() {
    _filterProviders();
  }

  void _filterProviders() {
    var providers = providersOriginal;
    if (selectedCategoryId != null) {
      providers =
          providers.where((e) => e.categoria.id == selectedCategoryId).toList();
    }
    if (filterTextFieldController.text.isNotEmpty) {
      providers = providers
          .where((e) => e.nome
              .toLowerCase()
              .contains(filterTextFieldController.text.toLowerCase()))
          .toList();
    }
    providersFuture = ObservableFuture(Future.value(providers));
  }
}
