import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

const API_BASE_URL = 'http://192.168.40.14:8000';

class ApiService{

  String _paramsToQueryString(Map<String, dynamic> params){
    Map<String, String> _params = {};

    params.entries.forEach((element) {
      _params = {
        ..._params,
        ...{element.key: "${element.value}"},
      };
    });

    return Uri(queryParameters: _params).query;
  }

  Future<Map<String, dynamic>> get(String path, [Map<String, dynamic> params = const {}]) async{
    final query = _paramsToQueryString(params);
    final url = "$API_BASE_URL$path/?$query";
    //final response = await http.get(Uri.parse(url));
     final response = await Dio().get(url);
     //return response.data;
    return {'results': response.data};
  }

  Future<Map<String, dynamic>> post(String path, [Map<String, dynamic> params = const {}]) async{
    final url = "$API_BASE_URL$path/";
    //final response = await http.post(Uri.parse(url), body: params.toString());
     final response = await Dio().post(url, data: params);
    //return {'results': json.decode(response.body)};
    return response.data;
  }

  Future<Map<String, dynamic>> put(String path, [Map<String, dynamic> params = const {}]) async{
    final url = "$API_BASE_URL$path/";
    //final response = await http.put(Uri.parse(url), body: params);
     final response = await Dio().put(url, data: params);
    //return {'results': json.decode(response.body)};
    return response.data;
  }

  Future<Map<String, dynamic>> delete(String path) async{
    final url = "$API_BASE_URL$path/";
    //final response = await http.delete(Uri.parse(url));
    final response = await Dio().delete(url);
    //return {'results': json.decode(response.body)};
    return response.data;
  }
}