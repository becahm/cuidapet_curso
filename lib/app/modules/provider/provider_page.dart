import 'package:cuidapet_curso/app/models/provider_detail_model.dart';
import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'provider_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderPage extends StatefulWidget {
  final int providerId;
  const ProviderPage({Key key, @required this.providerId}) : super(key: key);

  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState
    extends ModularState<ProviderPage, ProviderController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.initPage(widget.providerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<ProviderDetailModel>(
          future: controller.providerFuture,
          builder: (context, snapshot) {
            final provider = snapshot.data;
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
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao buscar dados do fornecedor'),
                  );
                }
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 300,
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(provider.nome),
                          background: Image.network(provider.logo),
                          stretchModes: [
                            StretchMode.fadeTitle,
                            StretchMode.zoomBackground,
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Informações do estabelecimento',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Clipboard.setData(
                                      ClipboardData(text: provider.endereco))
                                  .then((_) {
                                Get.snackbar(
                                    'Cópia', 'Endereço copiado com sucesso!');
                              });
                            },
                            leading:
                                Icon(Icons.location_city, color: Colors.black),
                            title: Text(provider.endereco),
                          ),
                          ListTile(
                            onTap: () async {
                              if (await canLaunch('tel:${provider.telefone}')) {
                                await launch('tel:${provider.telefone}');
                              } else {
                                Clipboard.setData(
                                        ClipboardData(text: provider.endereco))
                                    .then((_) {
                                  Get.snackbar(
                                      'Cópia', 'Telefone copiado com sucesso!');
                                });
                              }
                            },
                            leading: Icon(Icons.phone, color: Colors.black),
                            title: Text(provider.telefone),
                          ),
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Serviços (selecionados)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          FutureBuilder<List<ServiceModel>>(
                              future: controller.servicesFuture,
                              builder: (context, snapshot) {
                                final services = snapshot.data;

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
                                    if (snapshot.hasError) {
                                      return Center(
                                        child:
                                            Text('Erro ao carregar serviços!'),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return _buildServices(services);
                                    }
                                    return Center(
                                      child: Text('Nenhum dado encontrado.'),
                                    );
                                    break;
                                  default:
                                    return Container();
                                }
                              })
                        ]),
                      ),
                    ],
                  );
                }
                return Center(child: Text('Nenhum dado encontrado'));

                break;
              default:
                return Container();
                break;
            }
          }),
    );
  }

  ListView _buildServices(List<ServiceModel> services) {
    final formatReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: services.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final service = services[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: ThemeUtils.primaryColorLight,
            child: Icon(
              Icons.pets,
              color: Colors.black,
            ),
          ),
          title: Text(service.nome),
          subtitle: Text(formatReal.format(service.valor)),
          trailing: Icon(
            Icons.add_circle,
            color: ThemeUtils.primaryColor,
            size: 30,
          ),
        );
      },
    );
  }
}
