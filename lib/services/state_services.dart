import 'dart:convert';

import 'package:covid19_case_tracker/model/world_states_model.dart';
import 'package:covid19_case_tracker/services/utillities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<worldstatemodel> fetchworldrecord() async {
    final response = await http.get(Uri.parse(apiurl.worldstateApi));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return worldstatemodel.fromJson(data);
    } else {
      throw Exception('error ');
    }
  }

  Future<List<dynamic>?> countrylistapi() async {
    var data;
    final response = await http.get(Uri.parse(apiurl.countriesList));
    data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('error ');
    }
  }
}
