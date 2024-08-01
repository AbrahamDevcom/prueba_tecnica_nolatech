import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class WeatherApi {
  static Future<int?> getTodayRainPercentage(
    String date,
    double latitude,
    double longitude,
  ) async {
    const apiKey =
        '1f4e20a70b024b759e103006243007'; // Reemplaza con tu clave API de OpenWeatherMap

    final urlToday =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude, $longitude&aqi=no';

    final response = await http.get(Uri.parse(urlToday));

    if (response.statusCode == 200) {
      log(response.body);
      final data = jsonDecode(response.body);
      int rainPercentage = data['current']['humidity'];
      return rainPercentage;
    } else {
      print('Error: ${response.reasonPhrase}');
    }
    return null;
  }

  static Future<double?> getRainPercentage(
    String date,
    double latitude,
    double longitude,
  ) async {
    print(date);
    const apiKey =
        '1f4e20a70b024b759e103006243007'; // Reemplaza con tu clave API de OpenWeatherMap
    final url =
        'http://api.weatherapi.com/v1/future.json?key=$apiKey&q=$latitude,$longitude&dt=$date';

    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log(response.body);
      final data = jsonDecode(response.body);
      double rainPercentage =
          data["forecast"]["forecastday"][0]["day"]["avghumidity"];
      return rainPercentage;
    } else {
      print('Error: ${response.body}');
    }
    return null;
  }
}
