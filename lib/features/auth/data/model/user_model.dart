
class UserModel {
    final String id;
    final String email ;
    final String name;

    UserModel({required this.id,required this.email,required this.name});

    factory UserModel.fromJson(Map<String, dynamic> map) {
        return UserModel(
            id: map['id'] ?? '',
            email: map['email'] ?? '',
            name: map['name'] ?? '');
    }

    UserModel copyWith({String? name, String? id, String? email}) {
        return UserModel(
            name: name ?? this.name,
            id: id ?? this.id,
            email: email?? this.email
        );
    }
}
