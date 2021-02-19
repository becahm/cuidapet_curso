import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';

import 'detail_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key key,
    @required this.addressModel,
  }) : super(key: key);
  static final route = '/datail';
  final AddressModel addressModel;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ModularState<DetailPage, DetailController> {
  //use 'controller' variable to access controller

  final appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
  );

  @override
  Widget build(BuildContext context) {
    var location = widget.addressModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: _setScreenHeight(),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text('Confirme seu endereço',
                  style: ThemeUtils.theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(height: 20),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('end'),
                      infoWindow: InfoWindow(title: location.endereco),
                      position: LatLng(location.latitude, location.longitude),
                    )
                  },
                  myLocationButtonEnabled: false,
                ),
              ),
              TextFormField(
                initialValue: location.endereco,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffix: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Modular.to.pop(location),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.complementTextController,
                decoration: InputDecoration(labelText: 'Complemento'),
              ),
              SizedBox(height: 20),
              Container(
                width: ScreenUtil.screenWidthDp * .9,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    controller.saveAddress(location);
                  },
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20),
                  ),
                  color: ThemeUtils.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _setScreenHeight() {
    var bottomBar = Platform.isIOS ? ScreenUtil.bottomBarHeight : 0.0;
    return ScreenUtil.screenHeightDp -
        ScreenUtil.statusBarHeight -
        appBar.preferredSize.height -
        bottomBar;
  }
}
