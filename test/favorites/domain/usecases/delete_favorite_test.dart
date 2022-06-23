import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/favorites/domain/repository/favorites_repository.dart';
import 'package:mobile_challenge/favorites/domain/usecases/delete_favorite.dart';
import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/shared_mocks.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}

void main() {
  DeleteFavorite usecase;
  FavoritesRepository favoritesRepository;

  setUp(() {
    favoritesRepository = FavoritesRepositoryMock();
    usecase = DeleteFavorite(favoritesRepository);
  });

  test(
    'should get users in the favorites repository',
    () async {
      final response = UserModel.fromJson(jsonDecode(mockUser));

      usecase.execute(response);
      verify(favoritesRepository.delete(response)).called(1);
    },
  );
}
