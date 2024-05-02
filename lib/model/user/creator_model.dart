class CreatorQuizItemModel{
  String token;
  String? profilePic;
  String username;

  CreatorQuizItemModel({this.profilePic, required this.username, required this.token});

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      if (profilePic != null) "profilePic": profilePic,
      'username': username,
    };
  }

  CreatorQuizItemModel.fromJson(Map<String, dynamic> data)
      : token = data['uid'],
        username = data['username'],
        profilePic = data['profilePic'];
}