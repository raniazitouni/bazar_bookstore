class Review {
  final int id;
  final int targetId;
  final String targetType;
  final int rating;

  const Review({
    required this.id,
    required this.targetId,
    required this.targetType,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      targetId: json['target_id'] ?? 0,
      targetType: json['target_type'] ?? "",
      rating: json["rating"] ?? 0,
    );
  }
}
