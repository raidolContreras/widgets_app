import 'package:in_library/infrastructure/models/registers/login_user_result.dart';

class SelectUserDb {
    final LoginUserResult result;

    SelectUserDb({
        required this.result,
    });

    factory SelectUserDb.fromJson(Map<String, dynamic> json) {
        return SelectUserDb(
            result: LoginUserResult(
                idUser: json["result"]["idUser"],
                firstname: json["result"]["firstname"],
                lastname: json["result"]["lastname"],
                birthday: json["result"]["birthday"],
                email: json["result"]["email"],
                phone: json["result"]["phone"],
                creationDate: DateTime.parse(json["result"]["creationDate"]),
                message: json["result"]["message"],
            ),
        );
    }

    Map<String, dynamic> toJson() => {
        "result": result.toJson(),
    };
}
