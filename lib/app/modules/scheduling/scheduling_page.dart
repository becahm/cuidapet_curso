import 'package:cuidapet_curso/app/shared/components/cuidapet_textFormField.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'scheduling_controller.dart';

class SchedulingPage extends StatefulWidget {
  final int providerId;
  final List<ServiceModel> services;
  const SchedulingPage({
    Key key,
    @required this.providerId,
    @required this.services,
  }) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState
    extends ModularState<SchedulingPage, SchedulingController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    final formatReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Escolha uma data'),
            backgroundColor: Colors.white,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Observer(builder: (_) {
                return CalendarCarousel(
                  height: 420,
                  locale: 'pt_BR',
                  headerTextStyle:
                      TextStyle(color: ThemeUtils.primaryColor, fontSize: 25),
                  selectedDateTime: controller.selectedDate,
                  onDayPressed: (day, _) => controller.changeDate(day),
                );
              }),
              FlatButton(
                onPressed: () async {
                  var selectedTime = await showTimePicker(
                      context: context, initialTime: controller.selectedTime);
                  controller.changeTime(selectedTime);
                },
                textColor: ThemeUtils.primaryColor,
                child: Column(
                  children: [
                    Text('Selecione um horário'),
                    Observer(builder: (_) {
                      final time = controller.selectedTime;
                      return Text(time.format(context));
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Serviços',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.services.length,
                  itemBuilder: (context, index) {
                    final service = widget.services[index];
                    return ListTile(
                      title: Text(service.nome),
                      subtitle: Text(formatReal.format(service.valor)),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'Dados da reserva',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CuidapetTextFormField(
                        label: 'Seu Nome',
                        controller: controller.nameController,
                        validator: (value) =>
                            value.isEmpty ? 'Nome obrigatório' : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CuidapetTextFormField(
                        label: 'Nome do Pet',
                        controller: controller.petController,
                        validator: (value) =>
                            value.isEmpty ? 'Nome do pet obrigatório' : null,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                height: 60,
                width: ScreenUtil.screenWidthDp * 0.9,
                child: RaisedButton(
                  onPressed: () => controller.saveScheduling(
                      widget.providerId, widget.services),
                  color: ThemeUtils.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Agendar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
