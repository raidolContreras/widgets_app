class SelectUser {
  
  final int idUser;
  final String firstname;
  final String lastname;
  final String birthday;
  final String email;
  final String phone;
  final String creationDate;
  final dynamic error;

  SelectUser({
    required this.idUser,
    required this.firstname,
    required this.lastname,
    required this.birthday,
    required this.email,
    required this.phone,
    required this.creationDate, 
    required this.error, 
  });

}