import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/services/address_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'detail_controller.g.dart';

@Injectable()
class DetailController = _DetailControllerBase with _$DetailController;

abstract class _DetailControllerBase with Store {
  final AddressService _service;
  var complementTextController = TextEditingController();

  _DetailControllerBase(this._service);

  Future<void> saveAddress(AddressModel address) async {
    try {
      Loader.show();
      address.complemento = complementTextController.text;
      await _service.saveAddress(address);
      Loader.hide();
      print('endereço salvo com sucesso');
      Modular.to.pop();
    } catch (e) {
      Loader.hide();

      print(e);
      Get.snackbar('Erro', 'Erro ao salvar endereço');
    }
  }
}
