import 'package:bazar_bookstore/features/authors/controllers/author_controller.dart';
import 'package:bazar_bookstore/features/authors/models/author_model.dart';
import 'package:bazar_bookstore/features/authors/repository/author_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authorRepositoryProvidor = Provider<AuthorRepository>((ref) {
  return AuthorRepository();
});

enum AuthorCategory {
  all,
  novelist,
  poet,
  playwright,
  journalist,
  essayist,
  biographer,
  children,
  screenwriter,
  technical,
  academic,
  other,
}

final selectedCategoryProvider = StateProvider<AuthorCategory>((ref) {
  return AuthorCategory.all;
});

final filteredAuthorsProvider = Provider<AsyncValue<List<Author>>>((ref) {
  final selected = ref.watch(selectedCategoryProvider);
  final authorsAsync = ref.watch(authorControllerProvidor);

  return authorsAsync.whenData((authors) {
    if (selected == AuthorCategory.all) return authors;
    return authors.where((b) => b.category == selected).toList();
  });
});
