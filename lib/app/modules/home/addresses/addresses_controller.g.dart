// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AddressesController = BindInject(
  (i) => AddressesController(i<AddressService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressesController on _AddressesControllerBase, Store {
  final _$addressesFutureAtom =
      Atom(name: '_AddressesControllerBase.addressesFuture');

  @override
  ObservableFuture<List<AddressModel>> get addressesFuture {
    _$addressesFutureAtom.reportRead();
    return super.addressesFuture;
  }

  @override
  set addressesFuture(ObservableFuture<List<AddressModel>> value) {
    _$addressesFutureAtom.reportWrite(value, super.addressesFuture, () {
      super.addressesFuture = value;
    });
  }

  final _$sendAddressDetailAsyncAction =
      AsyncAction('_AddressesControllerBase.sendAddressDetail');

  @override
  Future<void> sendAddressDetail(Prediction pred) {
    return _$sendAddressDetailAsyncAction
        .run(() => super.sendAddressDetail(pred));
  }

  final _$myLocationAsyncAction =
      AsyncAction('_AddressesControllerBase.myLocation');

  @override
  Future<void> myLocation() {
    return _$myLocationAsyncAction.run(() => super.myLocation());
  }

  final _$selectAddressAsyncAction =
      AsyncAction('_AddressesControllerBase.selectAddress');

  @override
  Future<void> selectAddress(AddressModel address) {
    return _$selectAddressAsyncAction.run(() => super.selectAddress(address));
  }

  final _$_AddressesControllerBaseActionController =
      ActionController(name: '_AddressesControllerBase');

  @override
  Future<List<Prediction>> findAddresses(String address) {
    final _$actionInfo = _$_AddressesControllerBaseActionController.startAction(
        name: '_AddressesControllerBase.findAddresses');
    try {
      return super.findAddresses(address);
    } finally {
      _$_AddressesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyEditAddress(AddressModel editAddress) {
    final _$actionInfo = _$_AddressesControllerBaseActionController.startAction(
        name: '_AddressesControllerBase.verifyEditAddress');
    try {
      return super.verifyEditAddress(editAddress);
    } finally {
      _$_AddressesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
addressesFuture: ${addressesFuture}
    ''';
  }
}
