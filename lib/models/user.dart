class Users {
  final String id;
  final String email;
  final String firstName;
  final String lastName;

  Users({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Users.fromData(Map<String, dynamic> data)
      : id = data['id'],
        email = data['email'],
        firstName = data['firstName'],
        lastName = data['lastName'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
