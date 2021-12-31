import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String url; //날씨 정보
  final String url2;  //대기 정보
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) { //정상적인 출력, json 파싱 부분
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
  Future<dynamic> getAirData() async{
    http.Response response = await http.get(Uri.parse(url2));
    if(response.statusCode == 200) { //정상적인 출력, json 파싱 부분
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}