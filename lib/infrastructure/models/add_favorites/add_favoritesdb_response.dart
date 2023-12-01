class AddFavoriteDbResponse {
    final String message;

    AddFavoriteDbResponse({
        required this.message,
    });

    factory AddFavoriteDbResponse.fromJson(Map<String, dynamic> json) => AddFavoriteDbResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}