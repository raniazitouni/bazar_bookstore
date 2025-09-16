class Book {
  final int id;
  final String title;
  final String coverUrl;
  final String description;
  final double price;
  final String category;
  final int authorId;
  final int vendorId;

  const Book({
    required this.id,
    required this.authorId,
    required this.category,
    required this.coverUrl,
    required this.description,
    required this.price,
    required this.title,
    required this.vendorId,
  });

  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      coverUrl: json["cover_url"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] ?? 0.0,
      category: json["category"] ?? "",
      authorId: json["author_id"] ?? 0,
      vendorId: json["vendor_id"] ?? 0,
    );
  }

}
