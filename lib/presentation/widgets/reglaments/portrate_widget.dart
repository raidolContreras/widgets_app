import 'package:flutter/material.dart';
import 'package:in_library/domain/entities/reglaments.dart';
class PortrateWidget extends StatelessWidget {
  const PortrateWidget({
    super.key, 
    required this.colors,
    required this.reglament,
  });

  final ColorScheme colors;
  final Reglament reglament;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Hero(
          tag: 'cover_image',
          child: Image.network(
            'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${reglament.idTitles}/${reglament.coverName}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}