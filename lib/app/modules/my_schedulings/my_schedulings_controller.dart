import 'package:cuidapet_curso/app/models/scheduling_model.dart';
import 'package:cuidapet_curso/app/services/scheduling_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'my_schedulings_controller.g.dart';

@Injectable()
class MySchedulingsController = _MySchedulingsControllerBase
    with _$MySchedulingsController;

abstract class _MySchedulingsControllerBase with Store {
  final SchedulingService _schedulingService;

  _MySchedulingsControllerBase(this._schedulingService);

  @observable
  ObservableFuture<List<SchedulingModel>> futureSchedulings;

  void getSchedulings() {
    futureSchedulings = ObservableFuture(_schedulingService.getSchedulings());
  }
}
