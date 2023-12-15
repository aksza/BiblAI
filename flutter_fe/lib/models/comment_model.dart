class Comment{
  final int id;
  final String content;
  final int userId;
  final String userName;
  final String profilePictureUrl;
  int numLikes;
  int numDisLikes;
  bool likedByUser;
  bool dislikedByUser;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    required this.profilePictureUrl,
    required this.numLikes,
    required this.numDisLikes,
    required this.likedByUser,
    required this.dislikedByUser
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'userName': userName,
      'profilePictureUrl': profilePictureUrl,
      'numLikes': numLikes,
      'numDislikes' : numDisLikes,
      'likedByUser' : likedByUser,
      'dislikedByUser': dislikedByUser,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      content: json['content'] as String,
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
      numLikes: json['numLikes'] as int? ?? 0, // Ellenőrizd, hogy nem null
      numDisLikes: json['numDisLikes'] as int? ?? 0, // Ellenőrizd, hogy nem null
      likedByUser: json['likedByUser'] as bool? ?? false, // Ellenőrizd, hogy nem null
      dislikedByUser: json['dislikedByUser'] as bool? ?? false, // Ellenőrizd, hogy nem null
    );
  }
  
}