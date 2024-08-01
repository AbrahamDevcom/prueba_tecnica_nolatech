//Se utiliza para encapsular los datos de una solicitud HTTP
class HttpResult<Map> {
  //Mapa que contiene los datos de la respuesta HTTP
  final Map data;
  //Codigo de estado de la respuesta HTTP
  final int statusCode;
  /*
  Objeto de tipo HttpError que contiene informacion adicional en caso de que se produzca un 
  error durante la solicitud HTTP */
  final HttpError? error;

  HttpResult({
    required this.data,
    required this.statusCode,
    required this.error,
  });
}
//Representa un error en una solicitud HTTP
class HttpError {
  final Object? exception;
  final StackTrace stackTrace;
  final dynamic data;

  HttpError({
    required this.exception,
    required this.stackTrace,
    required this.data,
  });
}
