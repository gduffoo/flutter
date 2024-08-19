import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final authRepository = AuthRepositoryImpl();
    final keyValueStorageService = KeyValueStorageServiceImpl();

    return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService,
    );
  },
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState());

  //future que regresa un void
  //podria regresar el user.. deberia
  Future<void> loginUser(String email, String password) async {
    //await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredential {
      logout("Credenciales no son correctas");
    } on Connectiontimeout {
      logout("error timeOut");
    } catch (e) {
      logout("Error no controlado");
    }

    //final user = await authRepository.login(email, password);
    //state = state.copywith(authStatus: AuthStatus.authenticated, user: user);
  }

  void registerUser(String email, String password) async {}

  void checkStatus(String token) async {
    final token = await keyValueStorageService.getvalue<String>("token");
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatusn(token);
      _setLoggedUser(user);
    } on WrongCredential {
      logout("Token invalido");
    } on Connectiontimeout {
      logout("error timeOut");
    } catch (e) {
      logout("Token invalido");
    }
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey("token");

    state = state.copywith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue<String>("token", user.token);
    state = state.copywith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ""});

  AuthState copywith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
