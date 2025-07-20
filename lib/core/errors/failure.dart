import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure({required this.message});
}

// to determine the failure type may be server ,cache or network
// so we can handle the failure differently

class ServerFailure extends Failure {
  ServerFailure({required super.message});
  // make a factory constructor to create ServerFailure from DioException
  // factory constructor is a type of named constructor
  // عشان اختصر كواد كتير كنت هقعد اكتبها كل مرة فى الدوال المختلفة
  factory ServerFailure.fromDioError(DioException e) {
    // type is a enum
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection Timeout With Api Server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send Timeout With Api Server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive Timeout With Api Server');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad Certificate With Api Server');
      // bad response , other types of errors no response from the server
      // but here there is a response from the server but the status code is not 200
      // the request may be unsuccessful or wrong write the request
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request To Api Server Was Cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'Opps there was an error, Please Try Again',
        );
    }
  }
  factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
    // 400 request is wrong write
    // 401 , talks about authorization (token) may be wrong or not sent
    // 403 , token may be right but not allowed
    if (statusCode == 404) {
      return ServerFailure(
        message: 'Your request is not Valid, please try later',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        message: 'There is a problem with the server, please try later',
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      // Strucure of the error response depend on the API
      return ServerFailure(message: response['error']['message']);
    } else {
      return ServerFailure(
        message: 'Opps there was an error, Please Try Again',
      );
    }
  }
}
/////////////////////////////////////////////////

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

//////////////////////////////////////////////////
class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}
