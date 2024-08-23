// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final int? id;
  final String? fullName;
  final int? state;
  final int? lga;
  final String? community;
  final List<String>? groups;
  final String? email;
  final String? bio;
  final String? identificationDocument;
  final String? location;
  final String? gender;
  final String? mobile;
  final String? avatar;
  const UserModel({
    this.id,
    this.fullName,
    this.state,
    this.lga,
    this.groups,
    this.community,
    this.email,
    this.bio,
    this.identificationDocument,
    this.location,
    this.gender,
    this.mobile,
    this.avatar,
  });

  UserModel copyWith({
    int? id,
    String? fullName,
    int? state,
    int? lga,
    String? email,
    String? bio,
    List<String>? groups,
    String? identificationDocument,
    String? location,
    String? gender,
    String? mobile,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      state: state ?? this.state,
      lga: lga ?? this.lga,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      groups: groups ?? this.groups,
      identificationDocument:
          identificationDocument ?? this.identificationDocument,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'first_name': fullName,
        'lga': lga,
        'community': community,
        'email': email,
        'bio': bio,
        'identification_document': identificationDocument,
        'location': location,
        'gender': gender,
        'mobile': mobile,
        'avatar': avatar,
        'state': state,
      };

  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        fullName: json['full_name'] ?? '',
        lga: json['lga'],
        community: json['community'] ?? '',
        email: json['email'] ?? '',
        avatar: json['profile_pic'] ?? '',
        bio: json['bio'] ?? '',
        groups: json['groups'] ?? '',
        identificationDocument: json['identification_document'] ?? '',
        gender: json['gender'] ?? '',
        mobile: json['phone_number'] ?? '',
        state: json['state'],
        location: json['location'] ?? '',
      );

  @override
  String toString() {
    return 'UserModel(id: $id, full_name: $fullName,state: $state, lga: $lga, email: $email, bio: $bio, identification_document: $identificationDocument, location: $location, gender: $gender, phone_number: $mobile, profile_pic: $avatar, community: $community, groups: $groups)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.state == state &&
        other.lga == lga &&
        other.email == email &&
        other.groups == groups &&
        other.community == community &&
        other.bio == bio &&
        other.identificationDocument == identificationDocument &&
        other.location == location &&
        other.gender == gender &&
        other.mobile == mobile &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        state.hashCode ^
        lga.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        groups.hashCode ^
        community.hashCode ^
        identificationDocument.hashCode ^
        location.hashCode ^
        gender.hashCode ^
        mobile.hashCode ^
        avatar.hashCode;
  }
}
