import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/domain/entities/register_user.dart';
import 'package:in_library/infrastructure/datasources/register_userdb_datasource.dart';

class SendRegisterScreen extends ConsumerStatefulWidget {

  static const name = 'send_register_screen';

  final String nameUser;
  final String emailUser;
  final String passwordUser;
  const SendRegisterScreen({
    super.key,
    required this.nameUser,
    required this.emailUser,
    required this.passwordUser,
  });

  @override
  ConsumerState<SendRegisterScreen> createState() => _SendRegisterScreenState();
}

class _SendRegisterScreenState extends ConsumerState<SendRegisterScreen> {

  bool isLoading = true;
  late RegisterUser registerUser;

  @override
  void initState() {
    super.initState();
    _registerUser();
  }

  Future<void> _registerUser() async {
    final registerUserdbDatasource = RegisterUserdbDatasource();
    registerUser = await registerUserdbDatasource.getRegisterUser(
      widget.nameUser,
      widget.emailUser,
      widget.passwordUser
    );

    // Mostrar el indicador de carga durante 5 segundos
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    
    // Ocultar el indicador de carga y mostrar el mensaje
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2,),
        ),
      );
    }
    if (registerUser.message == 'Usuario creado con éxito'){
      return Scaffold(
        appBar: AppBar(
          title: const SizedBox(height: 20,)
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(child: Text(registerUser.message, style: const TextStyle(fontSize: 20),)),
              BounceInRight(
                child: TextButton.icon(
                  onPressed: (){
                    context.go('/login');
                  },
                  label: const Text('Iniciar sesión'),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const SizedBox(height: 20,)
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Image.network('https://static.vecteezy.com/system/resources/previews/001/195/701/non_2x/speech-bubbles-pixel-sorry-png.png')
              ),
              Text(registerUser.message, style: const TextStyle(fontSize: 20, color: Colors.red), ),
              BounceInRight(
                child: TextButton.icon(
                  onPressed: (){
                    context.go('/Register');
                  },
                  label: const Text('Vuelve a intentarlo'),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              )
            ],
          ),
        ),
      );
  }
}
