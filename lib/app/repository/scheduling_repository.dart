import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/viewsModels/scheduling_vm.dart';

class SchedulingRepository {
  Future<void> saveSchedue(SchedulingVM scheduling) async {
    await CustomDio.authInstance.post('/agendamento/agendar', data: {
      'data_agendamento': scheduling.dateTime.toIso8601String(),
      'fornecedor_id': scheduling.providerId,
      'servicos': scheduling.services.map<int>((s) => s.id).toList(),
      'nome': scheduling.ownerName,
      'nome_pet': scheduling.petName
    });
  }
}
