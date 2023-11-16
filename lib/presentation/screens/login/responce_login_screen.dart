import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/infrastructure/datasources/login_userdb.datasource.dart';
import 'package:in_library/presentation/providers/login_user/logged_user/logged_user_provider.dart';

class ResponceLoginScreen extends ConsumerStatefulWidget {
  static const name = 'responce_login_screen';

  final String emailUser;
  final String passwordUser;

  const ResponceLoginScreen({
    super.key,
    required this.emailUser,
    required this.passwordUser,
  });

  @override
  ConsumerState<ResponceLoginScreen> createState() => _ResponceLoginScreenState();
}

class _ResponceLoginScreenState extends ConsumerState<ResponceLoginScreen> {
  
  bool isLoading = true;
  late SelectUser loginUser;

  @override
  void initState() {
    super.initState();
    _loginUser();
  }

  Future<void> _loginUser() async {
    final loginUserdbDatasource = LoginUserdbDatasource();
    loginUser = await loginUserdbDatasource.loginUser(widget.emailUser, widget.passwordUser);

    await Future.delayed(const Duration(seconds: 1));
    
    // Ocultar el indicador de carga y mostrar el mensaje
    setState(() {
      isLoading = false;
      if (loginUser.message == 'Inicio exitoso'){
        ref.watch(loggedUserRepositoryProvider).toogleLogin(loginUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return isLoading
      ? const Scaffold(
        body: Center(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(strokeWidth: 2,),
              SizedBox(height: 20,),
              Text('Iniciando sesión')
            ],
          ),
        ),
      )
      : Scaffold(
        appBar: AppBar(
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginUser.message == 'Inicio exitoso'
                ? Text(loginUser.message)
                : Text(loginUser.message, style: const TextStyle(color: Colors.red, fontSize: 20),),
              
              TextButton.icon(onPressed: () {
                context.go('/');
              }, icon: const Icon(Icons.arrow_back_ios_new_outlined), label: const Text('Volver al inicio'))
            ],
          ),
        ),
      );

  }
}