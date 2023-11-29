import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/presentation/providers/providers.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  static const name = 'favorites_screen';
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

final isLoggedUser = FutureProvider.family.autoDispose((ref, int isarId) {
  final localStorageRepository = ref.watch(loggedUserRepositoryProvider);
  return localStorageRepository.islogged(isarId);
});

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis artículos favoritos'),
        centerTitle: true,
      ),
      body: const Center(
            // child: Text(userData[0].idUser),
          ),
    );
  }
}
