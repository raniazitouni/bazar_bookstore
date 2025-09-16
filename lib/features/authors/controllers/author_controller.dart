import 'dart:async';

import 'package:bazar_bookstore/features/authors/models/author_model.dart';
import 'package:bazar_bookstore/features/authors/providers/author_providor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthorController extends AsyncNotifier<List<Author>> {
  @override
  FutureOr<List<Author>> build() async {
    return [];
  }

  Future<void> getAllAuthors() async {
    final repo = ref.read(authorRepositoryProvidor);
    state = await AsyncValue.guard(repo.getAllAuthors);
  }
}

final authorControllerProvidor =
    AsyncNotifierProvider<AuthorController, List<Author>>(AuthorController.new);
