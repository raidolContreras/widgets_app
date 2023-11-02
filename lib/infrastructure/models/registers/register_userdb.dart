class RegisterUserDb {
    final String message;

    RegisterUserDb({
        required this.message,
    });

    factory RegisterUserDb.fromJson(Map<String, dynamic> json) => RegisterUserDb(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}