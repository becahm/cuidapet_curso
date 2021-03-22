import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/repository/address_repository.dart';
import 'package:google_maps_webservice/places.dart';

class AddressService {
  AddressRepository _repository;
  AddressService(
    this._repository,
  );

  Future<bool> hasRegisteredAdress() async {
    final addresses = await _repository.getAddresses();
    return addresses.isNotEmpty;
  }

  Future<List<Prediction>> findAddressesGooglePlaces(String address) async {
    return await _repository.findAddressGooglePlaces(address);
  }

  Future<void> saveAddress(AddressModel address) async {
    await _repository.saveAddress(address);
  }

  Future<List<AddressModel>> getRegisteredAddresses() async {
    return _repository.getAddresses();
  }

  Future<PlacesDetailsResponse> searchAddressDetailGooglePlaces(
      String placeId) {
    return _repository.getAddressDetailGooglePlaces(placeId);
  }

  Future<void> clearAddresses() {
    return _repository.clearAddresses();
  }
}
