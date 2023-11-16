import 'package:isar/isar.dart';

part 'select_user.g.dart';

@collection
class SelectUser {

  Id? isarId;
  
  final int idUser;
  String firstname;
  String lastname;
  String birthday;
  final String email;
  String phone;
  final String creationDate;
  final String message;

  SelectUser({
    required this.idUser,
    required this.firstname,
    required this.lastname,
    required this.birthday,
    required this.email,
    required this.phone,
    required this.creationDate, 
    required this.message, 
  });

}