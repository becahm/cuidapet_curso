import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'addresses_controller.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({Key key}) : super(key: key);

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState
    extends ModularState<AddressesPage, AddressesController> {
  @override
  void initState() {
    super.initState();
    //controller.searchAddresses();
  }
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var hasSelectedAddress = await controller.verifySelectedAddress();
        if (hasSelectedAddress) {
          return true;
        } else {
          Get.snackbar('Erro', 'Selecione um enedereço!');
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Adicione ou escolha um endereço',
                  style: ThemeUtils.theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      focusNode: controller.addressTextFocusNode,
                      controller: controller.addressTextController,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.location_on, color: Colors.black),
                        hintText: 'Insira um endereço',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                      ),
                    ),
                    onSuggestionSelected: (Prediction suggestion) {
                      controller.addressTextController.text =
                          suggestion.description;
                      controller.sendAddressDetail(suggestion);
                    },
                    itemBuilder: (context, Prediction itemData) {
                      return ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        title: Text(itemData.description),
                      );
                    },
                    suggestionsCallback: (pattern) async {
                      return await controller.findAddresses(pattern);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () async {
                    controller.myLocation();
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.near_me),
                    radius: 30,
                  ),
                  title: Text('Localização atual'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Observer(builder: (_) {
                  return FutureBuilder<List<AddressModel>>(
                      future: controller.addressesFuture,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Container();
                            break;
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                            break;
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              var addresses = snapshot.data;

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: addresses.length,
                                itemBuilder: (context, index) =>
                                    _buildAddressItem(addresses[index]),
                              );
                            } else {
                              return Center(
                                child: Text('Nenhum endereço cadastrado!'),
                              );
                            }
                            break;
                          default:
                            return Container();
                        }
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem(AddressModel address) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () => controller.selectAddress(address),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
          radius: 30,
        ),
        title: Text(address.endereco),
        subtitle: Text(address.complemento),
      ),
    );
  }
}
