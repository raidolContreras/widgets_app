import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/domain/repositories/local_storage_repository.dart';
import 'package:in_library/presentation/providers/providers.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, Map<int, SelectUser>>((ref) {
  final loginUserRepository = ref.watch(loggedUserRepositoryProvider);
  return UserDataNotifier(loginUserRepository: loginUserRepository);
});


class UserDataNotifier extends StateNotifier<Map<int, SelectUser>> {

  final LocalStorageRepository loginUserRepository;
  
  UserDataNotifier({
    required this.loginUserRepository
  }):super({});

  Future<void> loadDataUser() async {
    final dataUsers = await loginUserRepository.loadUserData();
    final tempUserMap = <int, SelectUser>{};

    for ( final user in dataUsers ) {

      tempUserMap[user.idUser] = user;

    }

    state = {...state, ...tempUserMap};
  }

}