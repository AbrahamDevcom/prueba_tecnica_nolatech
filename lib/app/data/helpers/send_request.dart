import 'dart:convert';

import 'package:http/http.dart';
import 'http_method.dart';


/// Esta función intenta codificar el body como JSON y devuelve el resultado 
/// codificado, si falla devuelve el body original.
dynamic _parseBody(dynamic body) {
  try {
    return jsonEncode(body);
  } catch (e) {
    return body;
  }
}

/// Esta función envía una solicitud HTTP con una url, method, headers, body y 
/// timeout especificados utilizando el paquete http.
Future<Response> sendRequest({
  required Uri url,
  required HttpMethod method,
  required Map<String, String> headers,
  required dynamic body,
  required Duration timeOut,
}) {

  /// Este ternario prepara los headers para la solicitud según el método 
  /// HTTP que se utiliza.
  var finalHeaders = {...headers};
  if (method != HttpMethod.get) {
    final contentType = headers["Content-Type"];
    if (contentType == null || contentType.contains("application/json")) {
      finalHeaders["Content-Type"] = "application/json; charset=UTF-8";
      body = _parseBody(body);
    }
  }
  final client = Client();

  /// El switch determina el método HTTP a usar según la enumeración HttpMethod
  /// proporcionada como argumento. Dependiendo del valor del método, ejecutará 
  /// la solicitud HTTP correspondiente utilizando el paquete http.
  switch (method) {
    case HttpMethod.get:
      return client
          .get(
            url,
            headers: finalHeaders,
          )
          .timeout(timeOut);
    case HttpMethod.post:
      return client
          .post(
            url,
            headers: finalHeaders,
            body: body,
          )
          .timeout(timeOut);
    case HttpMethod.put:
      return client
          .put(
            url,
            headers: finalHeaders,
            body: body,
          )
          .timeout(timeOut);
    case HttpMethod.patch:
      return client
          .patch(
            url,
            headers: finalHeaders,
            body: body,
          )
          .timeout(timeOut);
    case HttpMethod.detele:
      return client
          .delete(
            url,
            headers: finalHeaders,
            body: body,
          )
          .timeout(timeOut);
  }
}
