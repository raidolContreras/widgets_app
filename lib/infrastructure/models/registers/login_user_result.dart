
class LoginUserResult {
    final int idUser;
    final String firstname;
    final String lastname;
    final String birthday;
    final String email;
    final String phone;
    final DateTime creationDate;
    final String message;

    LoginUserResult({
        required this.idUser,
        required this.firstname,
        required this.lastname,
        required this.birthday,
        required this.email,
        required this.phone,
        required this.creationDate,
        required this.message,
    });

    factory LoginUserResult.fromJson(Map<String, dynamic> json) => LoginUserResult(
        idUser: json["idUser"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        birthday: json["birthday"],
        email: json["email"],
        phone: json["phone"],
        creationDate: DateTime.parse(json["creationDate"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "firstname": firstname,
        "lastname": lastname,
        "birthday": birthday,
        "email": email,
        "phone": phone,
        "creationDate": creationDate.toIso8601String(),
        "message": message,
    };
}
