import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cuidapet_curso/app/modules/my_schedulings/my_schedulings_controller.dart';
import 'package:cuidapet_curso/app/modules/my_schedulings/my_schedulings_module.dart';

void main() {
  initModule(MySchedulingsModule());
  // MySchedulingsController myschedulings;
  //
  setUp(() {
    //     myschedulings = MySchedulingsModule.to.get<MySchedulingsController>();
  });

  group('MySchedulingsController Test', () {
    //   test("First Test", () {
    //     expect(myschedulings, isInstanceOf<MySchedulingsController>());
    //   });

    //   test("Set Value", () {
    //     expect(myschedulings.value, equals(0));
    //     myschedulings.increment();
    //     expect(myschedulings.value, equals(1));
    //   });
  });
}
