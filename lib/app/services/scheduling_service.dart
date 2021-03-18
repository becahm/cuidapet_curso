import 'package:cuidapet_curso/app/repository/scheduling_repository.dart';
import 'package:cuidapet_curso/app/viewsModels/scheduling_vm.dart';

class SchedulingService {
  final SchedulingRepository _repository;

  SchedulingService(this._repository);

  Future<void> saveSchedule(SchedulingVM scheduling) async {
    await _repository.saveSchedue(scheduling);
  }
}
