class SelectUserDb {
    final Result result;

    SelectUserDb({
        required this.result,
    });

    factory SelectUserDb.fromJson(Map<String, dynamic> json) => SelectUserDb(
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result.toJson(),
    };
}

class Result {
    final int idUser;
    final String firstname;
    final String lastname;
    final String birthday;
    final String email;
    final String phone;
    final DateTime creationDate;

    Result({
        required this.idUser,
        required this.firstname,
        required this.lastname,
        required this.birthday,
        required this.email,
        required this.phone,
        required this.creationDate,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        idUser: json["idUser"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        birthday: json["birthday"],
        email: json["email"],
        phone: json["phone"],
        creationDate: DateTime.parse(json["creationDate"]),
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "firstname": firstname,
        "lastname": lastname,
        "birthday": birthday,
        "email": email,
        "phone": phone,
        "creationDate": creationDate.toIso8601String(),
    };
}
