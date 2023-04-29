import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<List<String>> getPlatforms(String utellyApiPath) async{

  var url = Uri.parse(utellyApiPath);
  var headers = {
    "X-RapidAPI-Key": "7869397766msheb6b77052e949d0p158ab7jsncc989e850d45" ,
    "X-RapidAPI-Host": "utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com"
  };

  var response = await http.get(url, headers: headers);
  List<String> res = [];
  if (response.statusCode != 200) {
    print("DEU MERDAAAAAAAAAAAAA");
    return res;
  }

  final data = jsonDecode(response.body);
  final locations = data['collection']['locations'];

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
  print('--------------');
  print('AFTER GETPLATFORMS');
  print(res);
  print('----------------');
  return res;
}

