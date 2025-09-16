import 'package:bazar_bookstore/features/authors/repository/author_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authorRepositoryProvidor = Provider<AuthorRepository>((ref) {
  return AuthorRepository();
});
