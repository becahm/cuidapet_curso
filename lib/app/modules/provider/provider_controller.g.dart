// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ProviderController = BindInject(
  (i) => ProviderController(i<ProviderService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProviderController on _ProviderControllerBase, Store {
  final _$providerFutureAtom =
      Atom(name: '_ProviderControllerBase.providerFuture');

  @override
  ObservableFuture<ProviderDetailModel> get providerFuture {
    _$providerFutureAtom.reportRead();
    return super.providerFuture;
  }

  @override
  set providerFuture(ObservableFuture<ProviderDetailModel> value) {
    _$providerFutureAtom.reportWrite(value, super.providerFuture, () {
      super.providerFuture = value;
    });
  }

  final _$servicesFutureAtom =
      Atom(name: '_ProviderControllerBase.servicesFuture');

  @override
  ObservableFuture<List<ServiceModel>> get servicesFuture {
    _$servicesFutureAtom.reportRead();
    return super.servicesFuture;
  }

  @override
  set servicesFuture(ObservableFuture<List<ServiceModel>> value) {
    _$servicesFutureAtom.reportWrite(value, super.servicesFuture, () {
      super.servicesFuture = value;
    });
  }

  final _$selectedServicesAtom =
      Atom(name: '_ProviderControllerBase.selectedServices');

  @override
  ObservableList<ServiceModel> get selectedServices {
    _$selectedServicesAtom.reportRead();
    return super.selectedServices;
  }

  @override
  set selectedServices(ObservableList<ServiceModel> value) {
    _$selectedServicesAtom.reportWrite(value, super.selectedServices, () {
      super.selectedServices = value;
    });
  }

  final _$_ProviderControllerBaseActionController =
      ActionController(name: '_ProviderControllerBase');

  @override
  void initPage(int providerId) {
    final _$actionInfo = _$_ProviderControllerBaseActionController.startAction(
        name: '_ProviderControllerBase.initPage');
    try {
      return super.initPage(providerId);
    } finally {
      _$_ProviderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getProviderDetail(int providerId) {
    final _$actionInfo = _$_ProviderControllerBaseActionController.startAction(
        name: '_ProviderControllerBase.getProviderDetail');
    try {
      return super.getProviderDetail(providerId);
    } finally {
      _$_ProviderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getProviderServices(int providerId) {
    final _$actionInfo = _$_ProviderControllerBaseActionController.startAction(
        name: '_ProviderControllerBase.getProviderServices');
    try {
      return super.getProviderServices(providerId);
    } finally {
      _$_ProviderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRemoveService(ServiceModel service) {
    final _$actionInfo = _$_ProviderControllerBaseActionController.startAction(
        name: '_ProviderControllerBase.addRemoveService');
    try {
      return super.addRemoveService(service);
    } finally {
      _$_ProviderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
providerFuture: ${providerFuture},
servicesFuture: ${servicesFuture},
selectedServices: ${selectedServices}
    ''';
  }
}
