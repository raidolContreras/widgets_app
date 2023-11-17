import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const name = 'search_screen';

  const SearchScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onChanged: (query) {
                // Implementa la lógica de búsqueda aquí
              },
            ),
            const SizedBox(height: 16),
            // Resultados de búsqueda
            Expanded(
              child: ListView(
                children: [
                  // Elementos de la lista como ListTile
                  buildResultItem('Resultado 1'),
                  buildResultItem('Resultado 2'),
                  // Agrega más elementos de la lista según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultItem(String resultText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[200],
      ),
      child: ListTile(
        title: Text(
          resultText,
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {
          // Acción cuando se selecciona un resultado
        },
      ),
    );
  }
}
