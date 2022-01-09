import 'dart:convert';

import 'package:api_app/constants/Strings.dart';
import 'package:api_app/models/news_info.dart';
import 'package:http/http.dart' as http;

class API_Manager {
  Future<Welcome> getNews() async{
    var client = http.Client();
    var welcome;

    try{
   var response = await client.get(Uri.parse(Strings.news_url));
   if(response.statusCode == 200) {
     var jsonString = response.body;
     var jsonMap = jsonDecode(jsonString);
     welcome = Welcome.fromJson(jsonMap);
   }
   return welcome;

   } catch (Exception) {
    return welcome;
    }
  }
}