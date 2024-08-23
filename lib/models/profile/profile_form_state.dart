class ProfileFormState {
  final int? id;
  final String? fullName;
  final String? state;
  final String? lga;
  final String? email;
  final String? bio;
  final String? identificationDocument;
  final String? location;
  final String? gender;
  final String? mobile;
  final String? avatar;
  final String? community;
  final bool isLoading;
  const ProfileFormState({
    this.id,
    this.fullName,
    this.state,
    this.lga,
    this.email,
    this.bio,
    this.identificationDocument,
    this.location,
    this.gender,
    this.mobile,
    this.avatar,
    this.community,
    this.isLoading = false,
  });

  ProfileFormState copyWith({
    int? id,
    String? fullName,
    String? state,
    String? lga,
    String? email,
    String? bio,
    String? identificationDocument,
    String? location,
    String? gender,
    String? mobile,
    String? avatar,
    String? community,
    bool? isLoading,
  }) {
    return ProfileFormState(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      state: state ?? this.state,
      lga: lga ?? this.lga,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      identificationDocument:
          identificationDocument ?? this.identificationDocument,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      avatar: avatar ?? this.avatar,
      community: community ?? this.community,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
