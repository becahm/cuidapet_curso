import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'scheduling_controller.g.dart';

@Injectable()
class SchedulingController = _SchedulingControllerBase
    with _$SchedulingController;

abstract class _SchedulingControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
