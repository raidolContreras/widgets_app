import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/domain/entities/update_user.dart';
import 'package:in_library/infrastructure/datasources/isar_datasource.dart';
import 'package:in_library/infrastructure/datasources/update_userdb_datasource.dart';

class UpdateDataScreen extends ConsumerStatefulWidget {
  static const name = 'update_data_screen';
  
  final String idUser;
  final String nameUser;
  final String lastnameUser;
  final String birthdayUser;
  final String phoneUser;

  const UpdateDataScreen({
    super.key,
    required this.idUser,
    required this.nameUser,
    required this.lastnameUser,
    required this.birthdayUser,
    required this.phoneUser
  });

  @override
  ConsumerState<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends ConsumerState<UpdateDataScreen> {
  
  bool isLoading = true;
  late UpdateUser updateUser;

  @override
  void initState() {
    super.initState();
    _updateUser();
  }
  Future<void> _updateUser() async {
    final updateUserdbDatasource = UpdateUserdbDatasource();
    updateUser = await updateUserdbDatasource.getUpdateUser(
      widget.idUser,
      widget.nameUser,
      widget.lastnameUser,
      widget.birthdayUser,
      widget.phoneUser
    );
    
    // Mostrar el indicador de carga durante 1 segundo
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    
    // Ocultar el indicador de carga y mostrar el mensaje
    setState(() {
      isLoading = false;
      if(updateUser.message == 'Datos actualizados con éxito'){
        IsarDatasource().updateData(
          widget.idUser,
          widget.nameUser,
          widget.lastnameUser,
          widget.birthdayUser,
          widget.phoneUser
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return isLoading
    ? const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black12),
            SizedBox(height: 20,),
            Text('Actualizando datos')
          ],
        ),
      ),
    )
    : updateUser.message == 'Datos actualizados con éxito'
      ? Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Datos Actualizados'),
              const SizedBox(height: 20,),
              TextButton.icon(onPressed: () => context.go('/'), icon: const Icon(Icons.arrow_back_ios_new_outlined), label: const Text('Inicio'))
            ],
          ),
        ),
      )
      : Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No se pudo actualizar el perfil'),
              const SizedBox(height: 20,),
              TextButton.icon(onPressed: () => context.go('/'), icon: const Icon(Icons.arrow_back_ios_new_outlined), label: const Text('Inicio'))
            ],
          ),
        ),
      );
  }

}