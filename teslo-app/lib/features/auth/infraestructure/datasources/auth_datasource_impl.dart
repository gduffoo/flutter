import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));
  @override
  Future<User> checkAuthStatusn(String token) {
    // TODO: implement checkAuthStatusn
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw WrongCredential();
    }
  }

  @override
  Future<User> register(String email, String password, String fullname) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
