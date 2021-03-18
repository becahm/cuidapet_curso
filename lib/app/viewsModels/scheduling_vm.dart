import 'package:cuidapet_curso/app/models/service_model.dart';
import 'package:flutter/foundation.dart';

class SchedulingVM {
  DateTime dateTime;
  String ownerName;
  String petName;
  int providerId;
  List<ServiceModel> services;
  SchedulingVM({
    @required this.dateTime,
    @required this.ownerName,
    @required this.petName,
    @required this.providerId,
    @required this.services,
  });
}
