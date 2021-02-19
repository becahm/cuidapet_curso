import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class AddressRepository {
  Future<List<AddressModel>> getAddresses() async {
    final conn = await Connection().instance;
    var result = await conn.rawQuery('select * from endereco');
    return result.map((e) => AddressModel.fromMap(e)).toList();
  }

  Future<void> saveAddress(AddressModel address) async {
    final conn = await Connection().instance;
    await conn.rawInsert('insert into endereco values (?, ?, ?, ?, ?)', [
      null,
      address.endereco,
      address.latitude,
      address.longitude,
      address.complemento
    ]);
  }

  Future<void> clearAddresses() async {
    final conn = await Connection().instance;
    await conn.rawDelete('delete from endereco');
  }

  Future<List<Prediction>> findAddressGooglePlaces(String address) async {
    final googlePlaces =
        GoogleMapsPlaces(apiKey: DotEnv().env['google_api_key']);
    var addresses = await googlePlaces.autocomplete(address, language: 'pt');
    return addresses.predictions;
  }

  Future<PlacesDetailsResponse> getAddressDetailGooglePlaces(String placeId) {
    final googlePlaces =
        GoogleMapsPlaces(apiKey: DotEnv().env['google_api_key']);
    return googlePlaces.getDetailsByPlaceId(placeId);
  }
}
