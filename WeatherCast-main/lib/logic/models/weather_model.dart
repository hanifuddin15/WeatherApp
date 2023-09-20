// class WeatherModel {
//   final String temp;
//   final String city;
//   final String desc;

//   WeatherModel.fromMap(Map<String, dynamic> json)
//       : temp = json['main']['temp'].toString(),
//         city = json['name'],
//         desc = json['weather'][0]['description'];
// }

///*************** */
///______Modified By Hanif_______
// class WeatherModel {
//   final double? temperature;
//   final int? humidity;
//   final String description;
//   final String city;

//   WeatherModel({
//     required this.temperature,
//     required this.humidity,
//     required this.description,
//     required this.city, 
    
//   });

//   // Add a factory method to parse JSON data
//   factory WeatherModel.fromJson(Map<String, dynamic> json) {
//     return WeatherModel(
//       temperature: json['main']['temp'].toDouble(),
//       humidity: json['main']['humidity'],
//       description: json['weather'][0]['description'], 
//       city: json['name'],
      
//     );
//   }
// }
////___End_______////

class WeatherModel {
  final double? temperature;
  final int? humidity;
  final String description;
  final String city;
  final String icon; // Add the icon field

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.description,
    required this.city,
    required this.icon, // Include the icon field
  });

  // Add a factory method to parse JSON data
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weatherData = json['weather'][0];
    return WeatherModel(
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      description: weatherData['description'],
      city: json['name'],
      icon: weatherData['icon'], // Parse the icon field
    );
  }
}
