/*
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'appExceptions.dart';
import 'logging_interceptor.dart';

enum RequestType { get, post, put, delete, patch }

class RequestModel {
  final RequestType type;
  final String url;
  final dynamic request;
  final Map<String, dynamic>? queryParameters;

  RequestModel(this.type, this.url, this.request, this.queryParameters);
}

class BaseService {


  int timeOut = 15;
  Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final String baseUrl = "api-sandbox.concord.digital";

  Future apiCall(RequestModel requestModel,{String? mfaTicket}) async {
    String token ="Token";
    Uri uri = Uri.https(baseUrl, requestModel.url, requestModel.queryParameters);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-session-token': '$token',
    };



    dynamic responseJson;
    try {
      final http.Response response;
      switch (requestModel.type) {
        case RequestType.get:
          response = await client.get(uri, headers: headers).timeout( Duration(seconds: timeOut));
          break;
        case RequestType.post:
          response = await client.post(uri,
              body: jsonEncode(requestModel.request), headers: headers).timeout( Duration(seconds: timeOut));
          break;
        case RequestType.put:
          response = await client.put(uri,
              body: jsonEncode(requestModel.request), headers: headers).timeout( Duration(seconds: timeOut));
          break;
        case RequestType.patch:
          response = await client.patch(uri,
              body: jsonEncode(requestModel.request), headers: headers).timeout( Duration(seconds: timeOut));
          break;
        case RequestType.delete:
          response = await client.delete(uri,
              body: jsonEncode(requestModel.request), headers: headers).timeout( Duration(seconds: timeOut));
          break;
      }
      print( "Response Code ${response.statusCode}------>");
      responseJson = returnResponse(response);
    } catch(e)  {
      rethrow;
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return true;

      case 400:
        throw BadRequestException(response.body.toString());
      case 401: {
        //LoginInfo().removeToken();
        throw UnauthorisedException(response.body.toString());
      }

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

}
*/
