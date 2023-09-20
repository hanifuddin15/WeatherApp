// import 'dart:convert';
// import 'dart:developer';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import "package:http/http.dart" as http;
// import 'package:weathercast/constants/api_key.dart';

// import 'package:weathercast/logic/models/weather_model.dart';

// class CallToApi {
//   Future<WeatherModel> callWeatherAPi(bool current, String cityName) async {
//     try {
//       Position currentPosition = await getCurrentPosition();
  
//       if (current) {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//             currentPosition.latitude, currentPosition.longitude);

//         Placemark place = placemarks[0];
//         cityName = place.locality!;
//       }

//       var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
//           {'q': cityName, "units": "metric", "appid": apiKey});
//       final http.Response response = await http.get(url);
//       log(response.body.toString());
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> decodedJson = json.decode(response.body);
//         return WeatherModel.fromMap(decodedJson);
//       } else {
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       throw Exception('Failed to load weather data');
//     }
//   }

//   Future<Position> getCurrentPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {

//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );
//   }
// }

//////***********modified by hanif */
// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:weathercast/constants/api_key.dart'; // Import your API key file.
// import 'package:weathercast/logic/models/weather_model.dart';

// class WeatherController extends GetxController {
//   var isLoading = false.obs;
//   var weather = WeatherModel().obs;

//   Future<void> fetchWeather(bool current, String cityName) async {
//     try {
//       if (current) {
//         final currentPosition = await getCurrentPosition();
//         final placemarks = await placemarkFromCoordinates(
//             currentPosition.latitude, currentPosition.longitude);

//         final place = placemarks[0];
//         cityName = place.locality!;
//       }

//       final url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
//           {'q': cityName, "units": "metric", "appid": apiKey});
//       final response = await http.get(url);
//       log(response.body.toString());

//       if (response.statusCode == 200) {
//         final decodedJson = json.decode(response.body);
//         final weatherData = WeatherModel.fromMap(decodedJson);
//         weather(weatherData);
//       } else {
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       throw Exception('Failed to load weather data');
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<Position> getCurrentPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );
//   }
// }
//////*******************End********************* */

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathercast/constants/api_key.dart';
import 'package:weathercast/logic/models/weather_model.dart';

class WeatherController extends GetxController {
  var isLoading = false.obs;
  var weather = WeatherModel(
    temperature: null,
    humidity: null,
    description: '',
    city: '', 
    icon: '',
  ).obs;
  var textController = TextEditingController();

  Future<void> fetchWeather(bool current, String cityName) async {
    try {
      if (current) {
        final currentPosition = await getCurrentPosition();
        final placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);

        final place = placemarks[0];
        cityName = place.locality!;
      }

      final url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
          {'q': cityName, "units": "metric", "appid": apiKey});
      final response = await http.get(url);
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final weatherData = WeatherModel.fromJson(decodedJson);
        weather(weatherData);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    } finally {
      isLoading(false);
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
