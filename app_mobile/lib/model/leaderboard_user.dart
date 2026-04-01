class LeaderboardUser {
  final String name;
  final int score;
  final int rank;
  final String avatar;

  const LeaderboardUser({
    required this.name,
    required this.score,
    required this.rank,
    required this.avatar,
  });

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      name: json['name']?.toString() ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      avatar: json['avatar']?.toString() ?? 'https://i.pinimg.com/736x/ea/52/41/ea524105940b91b96d70ff5216424463.jpg',
    );
  }
}