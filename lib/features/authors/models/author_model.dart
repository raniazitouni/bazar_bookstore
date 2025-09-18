import 'package:bazar_bookstore/features/authors/providers/author_providor.dart';

class Author {
  final int id;
  final String fullName;
  final String? pictureUrl;
  final String about;
  final AuthorCategory category;

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
      category: authorCategoryFromString(json['category']),
      pictureUrl: json['picture_url'],
    );
  }
}

AuthorCategory authorCategoryFromString(String category) {
  switch (category.toLowerCase()) {
    case 'novelist':
      return AuthorCategory.novelist;
    case 'poet': 
      return AuthorCategory.poet;
    case 'playwright':
      return AuthorCategory.playwright;
    case 'journalist':
      return AuthorCategory.journalist;
    case 'essayist':
      return AuthorCategory.essayist;
    case 'children':
      return AuthorCategory.children;
    case 'biographer':
      return AuthorCategory.biographer;
    case 'technical':
      return AuthorCategory.technical;
    case 'screenwriter':
      return AuthorCategory.screenwriter;
    case 'academic':
      return AuthorCategory.academic;
    case 'other':
      return AuthorCategory.other;
    default:
      return AuthorCategory.other;
  }
}
