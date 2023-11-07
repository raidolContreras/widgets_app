import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/presentation/providers/providers.dart';

class LogoutScreen extends ConsumerStatefulWidget {
  static const name = 'logout_screen';
  const LogoutScreen({super.key});
  

  @override
  ConsumerState<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends ConsumerState<LogoutScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _logoutUser();
  }
  Future<void> _logoutUser() async {
    
    ref.read(userDataProvider.notifier).loadDataUser();

    await Future.delayed(const Duration(seconds: 5));
    // Ocultar el indicador de carga y mostrar el mensaje
    setState(() {
      isLoading = false;
      
      final userData = ref.watch(userDataProvider).values.toList();
      for (final user in userData){
        ref.read(loggedUserRepositoryProvider).toogleLogin(user);
      }
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider).values.toList();
    return isLoading
      ? Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            final dataUser = userData[index];
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(strokeWidth: 2,),
                  const SizedBox(height: 20,),
                  const Text('Cerrando sesión:'),
                  const SizedBox(height: 20,),
                  Text('Nos vemos luego ${dataUser.firstname} ${dataUser.lastname}'),
                ],
              ),
            );
          }
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
                const Text('Sesión cerrada'),
                const SizedBox(height: 20,),
                TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('Regresa al inicio'))
              ],
            ))
      );

  }
}