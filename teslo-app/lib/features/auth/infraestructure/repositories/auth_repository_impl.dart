import 'package:teslo_shop/features/auth/domain/domain.dart';
import '../infraestructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatusn(String token) {
    return dataSource.checkAuthStatusn(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullname) {
    return dataSource.register(email, password, fullname);
  }
}
