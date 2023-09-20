// import 'dart:developer';

// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:weathercast/constants/constants.dart';
// import 'package:weathercast/logic/models/weather_model.dart';
// import 'package:weathercast/logic/services/call_to_api.dart';

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({Key? key}) : super(key: key);

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
//     return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
//   }

//   TextEditingController textController = TextEditingController(text: "");
//   Future<WeatherModel>? _myData;
//   @override
//   void initState() {
//     setState(() {
//       _myData = getData(true, "");
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: FutureBuilder(
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If error occured
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   '${snapshot.error.toString()} occurred',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               );

//               // if data has no errors
//             } else if (snapshot.hasData) {
//               // Extracting data from snapshot object
//               final data = snapshot.data as WeatherModel;
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment(0.8, 1),
//                     colors: <Color>[
//                       Color.fromARGB(255, 65, 89, 224),
//                       Color.fromARGB(255, 83, 92, 215),
//                       Color.fromARGB(255, 86, 88, 177),
//                       Color(0xfff39060),
//                       Color(0xffffb56b),
//                     ],
//                     tileMode: TileMode.mirror,
//                   ),
//                 ),
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: SafeArea(
//                   child: Column(
//                     children: [
//                       AnimSearchBar(
//                         rtl: true,
//                         width: 400,
//                         color: Color(0xffffb56b),
//                         textController: textController,
//                         suffixIcon: Icon(
//                           Icons.search,
//                           color: Colors.black,
//                           size: 26,
//                         ),
//                         onSuffixTap: () async {
//                           textController.text == ""
//                               ? log("No city entered")
//                               : setState(() {
//                                   _myData = getData(false, textController.text);
//                                 });

//                           FocusScope.of(context).unfocus();
//                           textController.clear();
//                         },
//                         style: f14RblackLetterSpacing2,
//                       ),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               data.city,
//                               style: f24Rwhitebold,
//                             ),
//                             height25,
//                             Text(
//                               data.desc,
//                               style: f16PW,
//                             ),
//                             height25,
//                             Text(
//                               "${data.temp}°C",
//                               style: f42Rwhitebold,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Center(
//               child: Text("${snapshot.connectionState} occured"),
//             );
//           }
//           return Center(
//             child: Text("Server timed out!"),
//           );
//         },
//         future: _myData!,
//       ),
//     );
//   }
// }
// import 'dart:math';

// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// //import 'package:weathercast/logic/controllers/weather_controller.dart'; // Import the WeatherController
// import 'package:weathercast/logic/models/weather_model.dart';

// import '../constants/constants.dart';
// import '../logic/services/call_to_api.dart';
// class WeatherPage extends StatelessWidget {
//   final WeatherController weatherController = Get.put(WeatherController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Obx(() {
//         final weatherData = weatherController.weather;

//         return Column(
//           children: [
//             AnimSearchBar(
//               rtl: true,
//               width: 400,
//               color: Color(0xffffb56b),
//               textController: weatherController.textController,
//               suffixIcon: Icon(
//                 Icons.search,
//                 color: Colors.black,
//                 size: 26,
//               ),
//               onSuffixTap: () async {
//                 if (weatherController.textController.text == "") {
//                   log("No city entered" as num);
//                 } else {
//                   await weatherController.fetchWeather(
//                     false,
//                     weatherController.textController.text,
//                   );
//                 }
//                 weatherController.textController.clear();
//               },
//               style: f14RblackLetterSpacing2,
//             ),
//             Expanded(
//               child: weatherData.value != null
//                   ? _buildWeatherInfo(weatherData.value)
//                   : _buildLoadingIndicator(),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildWeatherInfo(WeatherModel data) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment(0.8, 1),
//           colors: <Color>[
//             Color.fromARGB(255, 65, 89, 224),
//             Color.fromARGB(255, 83, 92, 215),
//             Color.fromARGB(255, 86, 88, 177),
//             Color(0xfff39060),
//             Color(0xffffb56b),
//           ],
//           tileMode: TileMode.mirror,
//         ),
//       ),
//       width: double.infinity,
//       height: double.infinity,
//       child: SafeArea(
//         child: Column(
//           children: [
//             Text(
//               data.city,
//               style: f24Rwhitebold,
//             ),
//             height25,
//             Text(
//               data.description,
//               style: f16PW,
//             ),
//             height25,
//             Text(
//               "${data.humidity}°C",
//               style: f42Rwhitebold,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:weathercast/logic/controllers/weather_controller.dart';
import 'package:weathercast/logic/models/weather_model.dart';

import '../constants/constants.dart';
import '../logic/services/call_to_api.dart';

class WeatherPage extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
               decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: <Color>[
          Color.fromARGB(255, 65, 89, 224),
          Color.fromARGB(255, 83, 92, 215),
          Color.fromARGB(255, 86, 88, 177),
          Color(0xfff39060),
          Color(0xffffb56b),
        ],
        tileMode: TileMode.mirror,
      ),
    ),

    
              child: Obx(() {
                final weatherData = weatherController.weather;
              
                return Column(
                  children: [
                    AnimSearchBar(
                      rtl: true,
                      width: 400,
                      color: Color(0xffffb56b),
                      textController: weatherController.textController,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 26,
                      ),
                      onSuffixTap: () async {
                        if (weatherController.textController.text.isEmpty) {
                          log("No city entered");
                        } else {
                          await weatherController.fetchWeather(
                            false,
                            weatherController.textController.text,
                          );
                        }
                        weatherController.textController.clear();
                      },
                      style: f14RblackLetterSpacing2,
                    ),
                    Expanded(
                      child: weatherData.value != null
                          ? _buildWeatherInfo(weatherData.value)
                          : _buildLoadingIndicator(),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await weatherController.fetchWeather(
                          true, // Fetch current weather
                          "",
                        );
                      },
                      child: Text('Refresh'),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildWeatherInfo(WeatherModel data) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: <Color>[
          Color.fromARGB(255, 65, 89, 224),
          Color.fromARGB(255, 83, 92, 215),
          Color.fromARGB(255, 86, 88, 177),
          Color(0xfff39060),
          Color(0xffffb56b),
        ],
        tileMode: TileMode.mirror,
      ),
    ),
    width: double.infinity,
    height: double.infinity,
    child: SafeArea(
      child: Column(
        children: [
          Text(
            "${data.city}", // Display the city name here
            style: f24Rwhitebold,
          ),
          height25,
          Text(
            data.description,
            style: f16PW,
          ),
          height25,
          Text(
            "${data.temperature}°C",
            style: f42Rwhitebold,
          ),
          height25,
          Text(
            "Humidity: ${data.humidity}%",
            style: f16PW,
          ),
          // You can add more weather information here as needed
        ],
      ),
    ),
  );
}


  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
