class Vendor {
  final int id;
  final String title;
  final String logoUrl;
  final String category;

  const Vendor({
    required this.id,
    required this.title,
    required this.logoUrl,
    required this.category,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      logoUrl: json["logo_url"] ?? "",
      category: json["category"] ?? "",
    );
  }
}
