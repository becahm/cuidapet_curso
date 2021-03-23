import 'package:cuidapet_curso/app/models/scheduling_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'my_schedulings_controller.dart';

class MySchedulingsPage extends StatefulWidget {
  final String title;
  const MySchedulingsPage({Key key, this.title = "Histórico de Agendamentos"})
      : super(key: key);

  @override
  _MySchedulingsPageState createState() => _MySchedulingsPageState();
}

class _MySchedulingsPageState
    extends ModularState<MySchedulingsPage, MySchedulingsController> {
  final dateFormat = DateFormat('dd/MM/yyyy');
  final status = {
    'P': 'Pendente',
    'CN': 'Confirmado',
    'F': 'Finalizado',
    'C': 'Cancelado'
  };
  @override
  void initState() {
    super.initState();
    controller.getSchedulings();
  }
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<SchedulingModel>>(
        future: controller.futureSchedulings,
        builder: (context, snapshot) {
          final schedulings = snapshot.data;
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
                return Center(child: Text('Erro ao carregar agendamentos!'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('Nenhum agendamento encontrado!'));
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: schedulings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final scheduling = schedulings[index];
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              dateFormat.format(scheduling.dataAgendamento),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        scheduling.fornecedor.logo),
                                  ),
                                  title: Text(scheduling.fornecedor.nome),
                                  subtitle: Text(status[scheduling.status]),
                                ),
                                Divider(),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: scheduling.servicos.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final service = scheduling.servicos[index];
                                    return ListTile(
                                      leading: Icon(
                                        Icons.looks_one,
                                        color: ThemeUtils.primaryColor,
                                      ),
                                      title: Text(service.nome),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }
}
