import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';
const apiKey = '9e1b6bc90520b347f70432c739d3a401';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3;
  double? longitude3;

  //앱을 실행시키자마자 내 위치(위도/경도) 출력
  void initState(){
    super.initState();
    getLocation();
  }

  void getLocation () async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    //위도 경도 불러올 때까지 기다려야 하므로 await 키워드 사용
    //await: future의 값 리턴될 때까지 기다려야 한다는 의미
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);
    
    Network network = Network('https://api.openweathermap.org/data/2.5/weather?'
        'lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric');

    var weatherData = await network.getJsonData();
    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,);
    }));
  }

  //날씨 정보 받아오기(더미데이터)
  /*void fetchData() async{

      var myJson = parsingData['weather'][0]['description'];
      print(myJson);

      var wind = parsingData['wind']['speed'];
      print(wind);

      var id = parsingData['id'];
      print(id);
    } else{
      print(response.statusCode);
    }
  }*/

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
