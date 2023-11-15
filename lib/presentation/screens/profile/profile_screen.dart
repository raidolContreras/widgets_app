import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/presentation/providers/providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const name = 'profile_screen';

  const ProfileScreen({
    super.key,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController birthdayController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    ref.read(userDataProvider.notifier).loadDataUser();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
    birthdayController = MaskedTextController(mask: '00/00/0000');
    phoneController = MaskedTextController(mask: '(000) 000-0000');
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final userData = ref.watch(userDataProvider).values.toList();

    if (userData.isNotEmpty) {
      firstnameController.text = userData[0].firstname;
      lastnameController.text = userData[0].lastname;
      birthdayController.text = userData[0].birthday;
      phoneController.text = userData[0].phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildTextFormField(
                    labelText: 'Nombre',
                    hintText: 'Ingresa tu nombre',
                    onSaved: (value) {
                      // No necesitas setState ya que estás usando un controlador
                    },
                    controller: firstnameController,
                  ),
                  const SizedBox(height: 16),
                  buildTextFormField(
                    labelText: 'Apellido',
                    hintText: 'Ingresa tu apellido',
                    onSaved: (value) {
                      // No necesitas setState ya que estás usando un controlador
                    },
                    controller: lastnameController,
                  ),
                  const SizedBox(height: 16),
                  buildTextFormField(
                    labelText: 'Fecha de Nacimiento',
                    hintText: 'DD/MM/AAAA',
                    controller: birthdayController,
                    onSaved: (value) {
                      // No necesitas setState ya que estás usando un controlador
                    },
                  ),
                  const SizedBox(height: 16),
                  buildTextFormField(
                    labelText: 'Teléfono',
                    hintText: '(###) ###-####',
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      // No necesitas setState ya que estás usando un controlador
                    },
                  ),
                  const SizedBox(height: 32),
                  FadeInDown(
                    delay: const Duration(milliseconds: 800),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Realizar acción de guardar
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                      ),
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String labelText,
    required String hintText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    required void Function(String?) onSaved,
  }) {
    final colors = Theme.of(context).colorScheme;
    return FadeInDown(
      delay: const Duration(milliseconds: 500),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
          fillColor: colors.background,
          filled: true,
        ),
        controller: controller,
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido';
          }
          return null;
        },
      ),
    );
  }
}
