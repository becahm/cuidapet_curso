import 'package:cuidapet_curso/app/models/provider_detail_model.dart';
import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: controller.selectedServices.isEmpty ? 0 : 1,
          child: FloatingActionButton.extended(
            onPressed: null,
            icon: Icon(Icons.schedule),
            backgroundColor: ThemeUtils.primaryColor,
            label: Text('Fazer agendamento'),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: buildBody(),
    );
  }

  FutureBuilder<ProviderDetailModel> buildBody() {
    return FutureBuilder<ProviderDetailModel>(
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
                        Observer(builder: (_) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Serviços (${controller.selectedServices.length} selecionado${controller.selectedServices.length <= 1 ? '' : 's'})',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)));
                        }),
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
                                      child: Text('Erro ao carregar serviços!'),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    return _buildServices(services, controller);
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
        });
  }

  Observer _buildServices(
      List<ServiceModel> services, ProviderController controller) {
    final formatReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Observer(builder: (_) {
      return ListView.builder(
        padding: EdgeInsets.only(
            bottom: controller.selectedServices.isNotEmpty ? 60 : 0),
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
              trailing: Observer(builder: (_) {
                return InkWell(
                  onTap: () => controller.addRemoveService(service),
                  child: controller.selectedServices.contains(service)
                      ? Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                          size: 30,
                        )
                      : Icon(
                          Icons.add_circle,
                          color: ThemeUtils.primaryColor,
                          size: 30,
                        ),
                );
              }));
        },
      );
    });
  }
}
