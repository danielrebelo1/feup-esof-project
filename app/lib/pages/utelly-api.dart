import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<List<String>> getPlatforms(String utellyApiPath) async{
  // https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/idlookup/source_id=97546&source=tmdb&country=us
  // utellyApiPath = 'https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/idlookup?source_id=97546&source=tmdb&country=us';


  //print('BEFORE URIPARSE $utellyApiPath');
  var url = Uri.parse(utellyApiPath);
  //print('AFTER URIPARSE $url');
  var headers = {
    "X-RapidAPI-Key": "7869397766msheb6b77052e949d0p158ab7jsncc989e850d45" ,
    "X-RapidAPI-Host": "utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com",
    "content-type": "application/octet-stream"
  };

  /*
  var response = await http.get(url, headers: headers);

  if (response.statusCode < 200 || response.statusCode > 299) {
    print("DEU MERDAAAAAAAAAAAAA ----- ${response.statusCode}");
    return res;
  }

  final data = jsonDecode(response.body);
  final locations = data['collection']['locations'];
  */
  List<String> res = [];
  final data, locations;
  try {
    var response = await http.get(url, headers: headers);
    if (response.statusCode < 200 || response.statusCode > 299) {
      print("DEU MERDAAAAAAAAAAAAA ----- ${response.statusCode}");
      return res;
    }
    data = jsonDecode(response.body);
    locations = data['collection']['locations'];
    // process the response as before
  } catch (e) {
    // handle any exceptions thrown by the HTTP request
    print('Error making HTTP request: $e');
    return res;
  }

  for (int i = 0; i < locations.length; i++){
    final String platform = locations[i]['display_name'];
    switch(platform){
      case "Netflix":
        {
          res.add("netflix.png");
          break;
        }
      case "Disney+":
        {
          res.add("disney.jpg");
          break;
        }
      case "Amazon Prime Video":
        {
          res.add("amazon-prime.png");
          break;
        }
      case "AppleTV+":
        {
          res.add("appletv.png");
          break;
        }
    }
  }
  /*
  print('--------------');
  print('AFTER GETPLATFORMS');
  print(res);
  print('----------------');
   */
  return res;
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
  // process the response as before
  } catch (e) {
  // handle any exceptions thrown by the HTTP request
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
