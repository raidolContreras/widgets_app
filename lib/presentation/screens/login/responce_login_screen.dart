import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/infrastructure/datasources/login_userdb.datasource.dart';

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
    loginUser = await loginUserdbDatasource.loginUser(emailUser: widget.emailUser, passwordUser: widget.passwordUser);

    // Mostrar el indicador de carga durante 5 segundos
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    
    // Ocultar el indicador de carga y mostrar el mensaje
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return isLoading
      ? const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 2,),
        ],
      )
      : Scaffold(
        appBar: AppBar(
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(loginUser.message)
            ],
          ),
        ),
      );

  }
}