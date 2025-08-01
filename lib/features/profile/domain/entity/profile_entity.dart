class UserProfileEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String address;
  final String gender;
  final String dob;
  final String lastSeen;

  UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.address,
    required this.gender,
    required this.dob,
    required this.lastSeen,
  });

  UserProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    String? address,
    String? gender,
    String? dob,
    String? lastSeen,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
