import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';  //위치 정보 받아오기 위해 geolocator 패키지 import
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  //앱을 실행시키자마자 내 위치(위도/경도) 출력
  void initState(){
    super.initState();
    getLocation();
    fetchData();
  }

  void getLocation () async{  //await가 사용되었기 때문에 이 메소드는 async 방식이 되어야 함
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //내 위치 정보 받아오기
      //desiredAccuracy: 위치 정확도
      print(position);
    } catch(e){
      print('인터넷 연결이 불안정합니다.');
    }
  }

  //날씨 정보 받아오기(더미데이터)
  void fetchData() async{
    http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?'
        'q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    if(response.statusCode == 200){ //정상적인 출력, json 파싱 부분
      String jsonData = response.body;
      var myJason = jsonDecode(jsonData)['weather'][0]['description'];
      var wind = jsonDecode(jsonData)['wind']['speed'];
      var id = jsonDecode(jsonData)['id'];
      print(myJason);
      print(wind);
      print(id);

    } else{
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Get my location',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ),
    );
  }
}
