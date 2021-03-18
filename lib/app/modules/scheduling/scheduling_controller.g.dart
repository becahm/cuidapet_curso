// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduling_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SchedulingController = BindInject(
  (i) => SchedulingController(i<SchedulingService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SchedulingController on _SchedulingControllerBase, Store {
  final _$selectedDateAtom =
      Atom(name: '_SchedulingControllerBase.selectedDate');

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  final _$selectedTimeAtom =
      Atom(name: '_SchedulingControllerBase.selectedTime');

  @override
  TimeOfDay get selectedTime {
    _$selectedTimeAtom.reportRead();
    return super.selectedTime;
  }

  @override
  set selectedTime(TimeOfDay value) {
    _$selectedTimeAtom.reportWrite(value, super.selectedTime, () {
      super.selectedTime = value;
    });
  }

  final _$saveSchedulingAsyncAction =
      AsyncAction('_SchedulingControllerBase.saveScheduling');

  @override
  Future<void> saveScheduling(int providerId, List<ServiceModel> services) {
    return _$saveSchedulingAsyncAction
        .run(() => super.saveScheduling(providerId, services));
  }

  final _$_SchedulingControllerBaseActionController =
      ActionController(name: '_SchedulingControllerBase');

  @override
  void changeDate(DateTime date) {
    final _$actionInfo = _$_SchedulingControllerBaseActionController
        .startAction(name: '_SchedulingControllerBase.changeDate');
    try {
      return super.changeDate(date);
    } finally {
      _$_SchedulingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTime(TimeOfDay time) {
    final _$actionInfo = _$_SchedulingControllerBaseActionController
        .startAction(name: '_SchedulingControllerBase.changeTime');
    try {
      return super.changeTime(time);
    } finally {
      _$_SchedulingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
selectedTime: ${selectedTime}
    ''';
  }
}
