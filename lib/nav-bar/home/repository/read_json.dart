import 'dart:convert';

import 'package:maqe/nav-bar/home/models/model.dart';
import 'package:flutter/services.dart' as s;

class ReadJsonRepository {

    Future<HolidayModel> ReadJ() async {
    final jsondata = await s.rootBundle.loadString("fixtures/holidays.json");
    dynamic theJson = jsonDecode(jsondata);
    return HolidayModel.fromJson(theJson);
  }

}
