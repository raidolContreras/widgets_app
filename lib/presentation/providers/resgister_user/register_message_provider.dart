import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/register_user.dart';
import 'package:in_library/presentation/providers/resgister_user/register_user_repository_impl.dart';

final registerMessageProvider = StateNotifierProvider<RegisterMapNotifier, Map<String, RegisterUser>>((ref) {

  final registerUserRepository = ref.watch(registerUserRepositoryProvider);

  return RegisterMapNotifier(getMessage: registerUserRepository.getRegisterUser);
});

typedef GetMessageCallback = Future<RegisterUser>Function(
  String messagePost, String arg2, String arg3
);

class RegisterMapNotifier extends StateNotifier<Map<String, RegisterUser>>{

  final GetMessageCallback getMessage;

  RegisterMapNotifier({
    required this.getMessage
  }): super({});

  Future<void> loadMessage(String messagePost) async {
    if (state[messagePost] != null) return;

    final message = await getMessage(messagePost, '', '');
    state = {...state, messagePost: message };
  }

}