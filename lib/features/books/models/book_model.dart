import 'package:bazar_bookstore/features/authors/models/author_model.dart';
import 'package:bazar_bookstore/features/books/providers/book_provider.dart';
import 'package:bazar_bookstore/features/reviews/models/review_model.dart';
import 'package:bazar_bookstore/features/vendors/models/vendor_model.dart';

class Book {
  final int id;
  final String title;
  final String coverUrl;
  final String description;
  final double price;
  final BookCategory category;
  final Author? author;
  final Vendor? vendor;
  final Review? review;

  const Book({
    required this.id,
    required this.category,
    required this.coverUrl,
    required this.description,
    required this.price,
    required this.title,
    this.author,
    this.review,
    this.vendor,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      coverUrl: json["cover_url"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] ?? 0.0,
      category: bookCategoryFromString(json["category"]),
      author: json["authors"] != null ? Author.fromJson(json["authors"]) : null,
      vendor: json['vendors'] != null ? Vendor.fromJson(json['vendors']) : null,
      review: json['reviews'] != null ? Review.fromJson(json['reviews']) : null,
    );
  }
}

BookCategory bookCategoryFromString(String category) {
  switch (category.toLowerCase()) {
    case 'fiction':
      return BookCategory.fiction;
    case 'nonfiction':
      return BookCategory.nonfiction;
    case 'fantasy':
      return BookCategory.fantasy;
    case 'sci-fi':
      return BookCategory.sciFi;
    case 'mystery':
      return BookCategory.mystery;
    case 'romance':
      return BookCategory.romance;
    case 'horror':
      return BookCategory.horror;
    case 'biography':
      return BookCategory.biography;
    case 'history':
      return BookCategory.history;
    case 'science':
      return BookCategory.science;
    case 'poetry':
      return BookCategory.poetry;
    case 'drama':
      return BookCategory.drama;
    case 'other':
      return BookCategory.other;
    default:
      return BookCategory.other;
  }
}
