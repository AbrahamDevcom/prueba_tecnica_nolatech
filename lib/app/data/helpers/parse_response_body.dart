import 'dart:convert';

/// La función intenta decodificar un responseBody JSON y devuelve un resultado
/// decodificado, o el responseBody original si falla la decodificación.
dynamic parseResponseBody(String responseBody) {
  try {
    return jsonDecode(responseBody);
  } catch (e) {
    return responseBody;
  }
}
