//위치 정보 받아오기 위해 geolocator 패키지 import
import 'package:geolocator/geolocator.dart';

class MyLocation{
  double? latitude2;
  double? longitude2;

  //await가 사용되었기 때문에 이 메소드는 async 방식이 되어야 함
  Future<void> getMyCurrentLocation() async{
  //loading.dart에서 해당 메소드를 호출할 때 await를 사용했기 때문에 future타입으로 값을 리턴해 주어야 한다.
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high); //await: 미래의 어느 시점에서 위치 정보를 받아옴
      //내 위치 정보 받아오기(desiredAccuracy: 위치 정확도)
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
    } catch(e){
      print('인터넷 연결이 불안정합니다.');
    }
  }
}