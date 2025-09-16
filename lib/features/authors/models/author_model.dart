class Author {
  final int id;
  final String fullName;
  final String? pictureUrl;
  final String about;
  final String category;

  const Author({
    required this.id,
    required this.fullName,
    required this.about,
    required this.category,
    this.pictureUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 0,
      fullName: json['fullname'] ?? "",
      about: json['about'] ?? "",
      category: json['category'] ?? "",
      pictureUrl: json['picture_url'],
    );
  }
}
