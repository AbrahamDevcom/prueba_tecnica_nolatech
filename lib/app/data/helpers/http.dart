import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
//import '../../domain/responses/error_response.dart';
import 'http_result.dart';
import 'parse_response_body.dart';
import 'send_request.dart';
import 'http_method.dart';

typedef Parser<T> = T Function(dynamic data);

/*
  Esta clase se encarga de manejar las solicitudes http, realiza las solicitidus http 
  y devuelve una respuesta en forma de http.response
 */
class Http {
  // URL base que se utiliza para construir la URL completa para la solicitud HTTP
  String baseUrl = "https://dashboard.homereadyglobal.com/api";
  //String baseUrl = "http://localhost:8000/api";

  Future<http.Response> request<T>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParams = const {},
    dynamic body,
    Parser<T>? parser,
    Duration timeOut = const Duration(seconds: 30),
  }) async {
    int? statusCode;
    Map<String, dynamic> data;
    log("Entry");
    late Uri url;
    if (path.startsWith("http://") || path.startsWith("https://")) {
      url = Uri.parse(path);
    } else {
      url = Uri.parse("$baseUrl$path");
    }

    if (queryParams.isNotEmpty) {
      url = url.replace(queryParameters: {
        ...url.queryParameters,
        ...queryParams,
      });
    }
    log("Entry_2 $url");
    // Se envía la solicitud HTTP utilizando la función 'sendRequest', que se define en otro archivo.
    var response = await sendRequest(
      url: url,
      method: method,
      headers: headers,
      body: body,
      timeOut: timeOut,
    );
    //log(response.body);
    log("Entry_3");
    log(response.body);
    // Si la respuesta HTTP es exitosa, se devuelven los datos obtenidos de la respuesta.
    if (response.statusCode == HttpStatus.ok) {
      log("Entry_4");
      //log(response.body);
      //final error = ErrorResponse.fromJson(response.body);

      return response;
    }

    data = parseResponseBody(response.body);
    statusCode = response.statusCode;
    // Si la respuesta tiene un código de estado HTTP superior a 400, se lanza una excepción HttpError.
    if (statusCode >= 400) {
      throw HttpError(
        data: data,
        stackTrace: StackTrace.current,
        exception: null,
      );
    }
    //log(response.toString());
    return response;
  }
}
