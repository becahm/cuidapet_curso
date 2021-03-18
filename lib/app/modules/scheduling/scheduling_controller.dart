import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:cuidapet_curso/app/modules/home/home_module.dart';
import 'package:cuidapet_curso/app/services/scheduling_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:cuidapet_curso/app/viewsModels/scheduling_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'scheduling_controller.g.dart';

@Injectable()
class SchedulingController = _SchedulingControllerBase
    with _$SchedulingController;

abstract class _SchedulingControllerBase with Store {
  final SchedulingService _schedulingService;

  @observable
  var selectedDate = DateTime.now();

  @observable
  var selectedTime = TimeOfDay.now();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final petController = TextEditingController();

  _SchedulingControllerBase(this._schedulingService);

  @action
  void changeDate(DateTime date) {
    selectedDate = date;
  }

  @action
  void changeTime(TimeOfDay time) {
    selectedTime = time;
  }

  @action
  Future<void> saveScheduling(
      int providerId, List<ServiceModel> services) async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        final schedulingVM = SchedulingVM(
            dateTime: DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
              0,
            ),
            ownerName: nameController.text,
            petName: petController.text,
            providerId: providerId,
            services: services);

        await _schedulingService.saveSchedule(schedulingVM);
        Loader.hide();
        Get.snackbar('Sucesso',
            'Agendamento realizado com sucesso! Aguarde confirmação do estabelecimento!');
        Future.delayed(
            Duration(seconds: 3),
            () async => await Modular.to.pushNamedAndRemoveUntil(
                HomeModule.route, ModalRoute.withName(HomeModule.route)));
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao realizar agendamento');
      }
    }
  }
}
