import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/modules/home/addresses/detail/detail_page.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/services/address_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'addresses_controller.g.dart';

@Injectable()
class AddressesController = _AddressesControllerBase with _$AddressesController;

abstract class _AddressesControllerBase with Store {
  final AddressService _service;

  _AddressesControllerBase(this._service);
  var addressTextController = TextEditingController();
  var addressTextFocusNode = FocusNode();

  @observable
  ObservableFuture<List<AddressModel>> addressesFuture;

  @action
  Future<List<Prediction>> findAddresses(String address) {
    return _service.findAddressesGooglePlaces(address);
  }

  @action
  Future<void> sendAddressDetail(Prediction pred) async {
    var responseDetails =
        await _service.searchAddressDetailGooglePlaces(pred.placeId);
    var detail = responseDetails.result;
    var addressModel = AddressModel(
        id: null,
        endereco: detail.formattedAddress,
        latitude: detail.geometry.location.lat,
        longitude: detail.geometry.location.lng,
        complemento: null);
    var editAddress = await Modular.link
        .pushNamed(DetailPage.route, arguments: addressModel) as AddressModel;
    verifyEditAddress(editAddress);
  }

  @action
  Future<void> myLocation() async {
    Loader.show();
    var geolocator = Geolocator();
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var placemark = await geolocator.placemarkFromPosition(position);
    var place = placemark[0];
    var address = '${place.thoroughfare} ${place.subThoroughfare}';
    var addressModel = AddressModel(
        id: null,
        endereco: address,
        latitude: position.latitude,
        longitude: position.longitude,
        complemento: null);
    Loader.hide();
    var editAddress = await Modular.link
        .pushNamed(DetailPage.route, arguments: addressModel) as AddressModel;
    verifyEditAddress(editAddress);
  }

  @action
  void verifyEditAddress(AddressModel editAddress) {
    if (editAddress == null) {
      addressTextController.text = '';
      searchAddresses();
    } else {
      addressTextController.text = editAddress.endereco;
      addressTextFocusNode.requestFocus();
    }
  }

  @action
  Future<void> searchAddresses() async {
    addressesFuture = ObservableFuture(_service.getRegisteredAddresses());
  }

  @action
  Future<void> selectAddress(AddressModel address) async {
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerSelectedAddress(address);
    Modular.to.pop();
  }

  Future<bool> verifySelectedAddress() async {
    final prefs = await SharedPrefsRepository.instance;
    return prefs.selectedAddress != null;
  }
}
