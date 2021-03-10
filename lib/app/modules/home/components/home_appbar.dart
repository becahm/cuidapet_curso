import 'package:cuidapet_curso/app/modules/home/addresses/addresses_module.dart';
import 'package:cuidapet_curso/app/modules/home/home_controller.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppBar extends PreferredSize {
  final HomeController controller;
  HomeAppBar(this.controller)
      : super(
          preferredSize: Size(double.infinity, 100),
          child: AppBar(
            backgroundColor: Colors.grey[100],
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Cuidapet',
                style: TextStyle(color: Colors.white),
              ),
            ),
            elevation: 0,
            flexibleSpace: Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  color: ThemeUtils.primaryColor,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        controller: controller.filterTextFieldController,
                        onChanged: (name) => controller.filterByName(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.search,
                              size: 30,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () async {
                  await Modular.link.pushNamed(AddressesModule.route);
                  await controller.getSelectedAddress();
                  controller.getProviders();
                },
              )
            ],
          ),
        );
}
