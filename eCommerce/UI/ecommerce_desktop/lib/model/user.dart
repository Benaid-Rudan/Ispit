class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String username;
  String passwordHash;
  String passwordSalt;
  bool isActive;
  DateTime createdAt;
  DateTime? lastLoginAt;
  String? phoneNumber;
  List<UserRole> userRoles;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.passwordHash,
    required this.passwordSalt,
    required this.isActive,
    required this.createdAt,
    this.lastLoginAt,
    this.phoneNumber,
    required this.userRoles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        username: json['username'],
        passwordHash: json['passwordHash'],
        passwordSalt: json['passwordSalt'],
        isActive: json['isActive'],
        createdAt: DateTime.parse(json['createdAt']),
        lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : null,
        phoneNumber: json['phoneNumber'],
        userRoles: (json['userRoles'] as List<dynamic>?)
                ?.map((e) => UserRole.fromJson(e))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'username': username,
        'passwordHash': passwordHash,
        'passwordSalt': passwordSalt,
        'isActive': isActive,
        'createdAt': createdAt.toIso8601String(),
        'lastLoginAt': lastLoginAt?.toIso8601String(),
        'phoneNumber': phoneNumber,
        'userRoles': userRoles.map((e) => e.toJson()).toList(),
      };
}

class UserRole {
  int id;
  String name;

  UserRole({
    required this.id,
    required this.name,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}