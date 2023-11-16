import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/presentation/providers/login_user/login_user_repository_provider.dart';

final loadLoginUserProvider = StateNotifierProvider<LoginMapNotifier,  Map<String, SelectUser>>((ref) {
  final loadLoginUserRepository = ref.watch(loginUserRepositoryProvider).loginUser;
  return LoginMapNotifier(getData: loadLoginUserRepository);
});

typedef TitleCallback = Future<SelectUser> Function(
  String emailUser, String passwordUser
);

class LoginMapNotifier extends StateNotifier<Map<String, SelectUser>>{

  final TitleCallback getData;

  LoginMapNotifier({
    required this.getData
  }): super({});
  
  Future<void> loadDataUser( String email, String password) async{
    if (state[email] != null || state[password] != null ) return;
    
    final loginUser = await getData(email, password);

    state = {
      'email': loginUser, // Asigna el resultado del login al email
      'password': loginUser, // Asigna el resultado del login a la contraseña
    };

  }

}