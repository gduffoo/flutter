import 'dart:async';

import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));
  @override
  Future<User> checkAuthStatusn(String token) async {
    //auth/check-status
    try {
      final response = await dio
          .get('/auth/check-status',
              options: Options(headers: {'Authorization': 'Bearer $token'}))
          .catchError(onError);
      //if (response.statusCode == 401) throw WrongCredential();();

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredential();
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Connectiontimeout();
      }
      throw WrongCredential();
    } on WrongCredential {
      throw WrongCredential();
    } catch (e) {
      throw UnimplementedError();
      //return "Unknown Error";
    }
  }

  static onError(error) {
    //print("el error es ${error.type}");
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw WrongCredential();

      case DioExceptionType.sendTimeout:
        throw WrongCredential();

      case DioExceptionType.receiveTimeout:
        //return "Timeout occurred while sending or receiving";
        throw WrongCredential();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              //case StatusCode.badRequest:
              //return "Bad Request";
              throw WrongCredential();

            case 401:
              //case StatusCode.unauthorized:
              throw WrongCredential();

            case 403:
              //case StatusCode.forbidden:
              //return "Unauthorized";
              throw WrongCredential();

            case 404:
              //case StatusCode.notFound:
              //return "Not Found";
              throw WrongCredential();

            case 409:
              //case StatusCode.conflict:
              // return 'Conflict';
              throw WrongCredential();

            case 500:
              //case StatusCode.internalServerError:
              // return "Internal Server Error";
              throw WrongCredential();
          }
          break;
        }
        break;
      case DioExceptionType.cancel:
        throw WrongCredential();

      case DioExceptionType.unknown:
        //return "No Internet Connection";
        throw WrongCredential();

      case DioExceptionType.badCertificate:
        //return "Internal Server Error";
        throw WrongCredential();

      case DioExceptionType.connectionError:
        //return "Connection Error";
        throw WrongCredential();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      }).catchError(onError);
      //if (response.statusCode == 401) throw WrongCredential();();

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredential();
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Connectiontimeout();
      }
      throw WrongCredential();
    } on WrongCredential {
      throw WrongCredential();
    } catch (e) {
      throw UnimplementedError();
      //return "Unknown Error";
    }

    //throw UnimplementedError();
    /*
    on DioExceptionType.bad
    
    on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredential();();
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Connectiontimeout();
      }
      throw  WrongCredential;
    } catch (e) {
      throw  WrongCredential;
    }
    */
  }

  @override
  Future<User> register(String email, String password, String fullname) {
    throw UnimplementedError();
  }
}
