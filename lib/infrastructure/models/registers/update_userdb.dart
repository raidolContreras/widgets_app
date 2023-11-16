class UpdateUserDb {
    final String message;

    UpdateUserDb({
        required this.message,
    });

    factory UpdateUserDb.fromJson(Map<String, dynamic> json) => UpdateUserDb(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}