import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/modules/provider/provider_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProviderGridItem extends StatelessWidget {
  final ProviderSearchModel _provider;
  const ProviderGridItem(this._provider, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Modular.to.pushNamed(ProviderModule.route, arguments: _provider.id),
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            margin: EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Container(
              height: 120,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Text(
                      _provider.nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                      '${_provider.distancia.toStringAsFixed(2)} km de distância'),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child:
                  CircleAvatar(radius: 40, backgroundColor: Colors.grey[100]),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 5,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(_provider.logo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
