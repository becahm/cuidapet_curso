// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(
      i<AddressService>(), i<CategoriesService>(), i<ProviderService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$selectedAddressAtom =
      Atom(name: '_HomeControllerBase.selectedAddress');

  @override
  AddressModel get selectedAddress {
    _$selectedAddressAtom.reportRead();
    return super.selectedAddress;
  }

  @override
  set selectedAddress(AddressModel value) {
    _$selectedAddressAtom.reportWrite(value, super.selectedAddress, () {
      super.selectedAddress = value;
    });
  }

  final _$categoriesFutureAtom =
      Atom(name: '_HomeControllerBase.categoriesFuture');

  @override
  ObservableFuture<List<CategoryModel>> get categoriesFuture {
    _$categoriesFutureAtom.reportRead();
    return super.categoriesFuture;
  }

  @override
  set categoriesFuture(ObservableFuture<List<CategoryModel>> value) {
    _$categoriesFutureAtom.reportWrite(value, super.categoriesFuture, () {
      super.categoriesFuture = value;
    });
  }

  final _$selectedPageAtom = Atom(name: '_HomeControllerBase.selectedPage');

  @override
  int get selectedPage {
    _$selectedPageAtom.reportRead();
    return super.selectedPage;
  }

  @override
  set selectedPage(int value) {
    _$selectedPageAtom.reportWrite(value, super.selectedPage, () {
      super.selectedPage = value;
    });
  }

  final _$providersFutureAtom =
      Atom(name: '_HomeControllerBase.providersFuture');

  @override
  ObservableFuture<List<ProviderSearchModel>> get providersFuture {
    _$providersFutureAtom.reportRead();
    return super.providersFuture;
  }

  @override
  set providersFuture(ObservableFuture<List<ProviderSearchModel>> value) {
    _$providersFutureAtom.reportWrite(value, super.providersFuture, () {
      super.providersFuture = value;
    });
  }

  final _$selectedCategoryIdAtom =
      Atom(name: '_HomeControllerBase.selectedCategoryId');

  @override
  int get selectedCategoryId {
    _$selectedCategoryIdAtom.reportRead();
    return super.selectedCategoryId;
  }

  @override
  set selectedCategoryId(int value) {
    _$selectedCategoryIdAtom.reportWrite(value, super.selectedCategoryId, () {
      super.selectedCategoryId = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('_HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$verifyIfHasAddressAsyncAction =
      AsyncAction('_HomeControllerBase.verifyIfHasAddress');

  @override
  Future<void> verifyIfHasAddress() {
    return _$verifyIfHasAddressAsyncAction
        .run(() => super.verifyIfHasAddress());
  }

  final _$getSelectedAddressAsyncAction =
      AsyncAction('_HomeControllerBase.getSelectedAddress');

  @override
  Future<void> getSelectedAddress() {
    return _$getSelectedAddressAsyncAction
        .run(() => super.getSelectedAddress());
  }

  final _$getProvidersAsyncAction =
      AsyncAction('_HomeControllerBase.getProviders');

  @override
  Future<void> getProviders() {
    return _$getProvidersAsyncAction.run(() => super.getProviders());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void changeSelectedPage(int page) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeSelectedPage');
    try {
      return super.changeSelectedPage(page);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCategories() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getCategories');
    try {
      return super.getCategories();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterCategory(int id) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filterCategory');
    try {
      return super.filterCategory(id);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterByName() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filterByName');
    try {
      return super.filterByName();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAddress: ${selectedAddress},
categoriesFuture: ${categoriesFuture},
selectedPage: ${selectedPage},
providersFuture: ${providersFuture},
selectedCategoryId: ${selectedCategoryId}
    ''';
  }
}
