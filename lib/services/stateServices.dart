import 'dart:convert';

import 'package:covid_app/model/WorldStateModel.dart';
import 'package:covid_app/services/utils/app_url.dart';

import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> fetchWorldStateRecord () async {
    final http.Response response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }
}