import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/update_user.dart';
import 'package:in_library/presentation/providers/update_user/update_user_repository_provider.dart';

final updateUserMessageProvider = StateNotifierProvider<UpdateMapNotifier, Map<String, UpdateUser>>((ref) {
  final updateUserRepository = ref.watch(updateUserRepositoryProvider).getUpdateUser;
  return UpdateMapNotifier(getMessage: updateUserRepository);
});

typedef GetMessageCallback = Future<UpdateUser>Function(
  String messagePost, String arg2, String arg3, String arg4, String arg5
);

class UpdateMapNotifier extends StateNotifier<Map<String, UpdateUser>>{

  final GetMessageCallback getMessage;

  UpdateMapNotifier({
    required this.getMessage
  }): super({});

  Future<void> loadMessage(String messagePost) async {
    if (state[messagePost] != null) return;

    final message = await getMessage(messagePost, '', '', '', '');
    state = {...state, messagePost: message };
  }

}