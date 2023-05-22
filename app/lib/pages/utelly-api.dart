import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<List<String>> getPlatforms(String utellyApiPath) async{

  var url = Uri.parse(utellyApiPath);

  var headers = {
    "X-RapidAPI-Key": "7869397766msheb6b77052e949d0p158ab7jsncc989e850d45" ,
    "X-RapidAPI-Host": "utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com",
    "content-type": "application/octet-stream"
  };
  print("BEFORE THE TRY");
  List<String> res = [];
  final data, locations;
  try {
    var response = await http.get(url, headers: headers);
    if (response.statusCode < 200 || response.statusCode > 299) {
      print("ERRO");
      return res;
    }
    data = jsonDecode(response.body);
    locations = data['collection']['locations'];
  } catch (e) {
    print('Error making HTTP request: $e');
    return res;
  }
  print("before the for");
  for (int i = 0; i < locations.length; i++){
    final String platform = locations[i]['display_name'];
    switch(platform){
      case "Netflix":
        {
          res.add("netflix.png");
          print("vou retornar $res");
          return res;
        }
      case "Disney+":
        {
          res.add("disney.jpg");
          print("vou retornar $res");
          return res;
        }
      case "Amazon Prime Video":
        {
          res.add("amazon-prime.png");
          print("vou retornar $res");
          return res;
        }
      case "AppleTV+":
        {
          res.add("appletv.png");
          print("vou retornar $res");
          return res;
        }
    }
  }
  print("nao encontrei nada");
  return [];
}

Future<List<String>> getMediaURL(String utellyApiPath) async{
  var url = Uri.parse(utellyApiPath);
  var headers = {
  "X-RapidAPI-Key": "7869397766msheb6b77052e949d0p158ab7jsncc989e850d45" ,
  "X-RapidAPI-Host": "utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com",
  "content-type": "application/octet-stream"
  };
  List<String> res=[];
  final data, locations;
  try {
  var response = await http.get(url, headers: headers);
  if (response.statusCode < 200 || response.statusCode > 299) {
  return res;
  }
  data = jsonDecode(response.body);
  locations = data['collection']['locations'];
  } catch (e) {
  print('Error making HTTP request: $e');
  return res;
  }

  for (int i = 0; i < locations.length; i++){
    final String platform = locations[i]['display_name'];
    switch(platform){
      case "Netflix":
        {
          res.add(locations[i]['url']);
          break;
        }
      case "Disney+":
        {
          res.add(locations[i]['url']);
          break;
        }
      case "Amazon Prime Video":
        {
          res.add(locations[i]['url']);
          break;
        }
      case "AppleTV+":
        {
          res.add(locations[i]['url']);
          break;
        }
    }
  }
  return res;
}


