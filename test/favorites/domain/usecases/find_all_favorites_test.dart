import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/favorites/domain/repository/favorites_repository.dart';
import 'package:mobile_challenge/favorites/domain/usecases/find_all_favorites.dart';
import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/shared_mocks.dart';
import '../../mocks/favorites_repository_mock.dart';

void main() {
  FindAllFavorites usecase;
  FavoritesRepository favoritesRepository;

  setUp(() {
    favoritesRepository = FavoritesRepositoryMock();
    usecase = FindAllFavorites(favoritesRepository);
  });

  test(
    'should get users in the favorites repository',
    () async {
      final data = jsonDecode(mockUserList)["data"] as List;
      final response = data.map((e) => UserModel.fromJson(e)).toList();

      when(favoritesRepository.findAll()).thenAnswer((_) async => response);

      final result = await usecase.execute();

      expect(result, response);
    },
  );
}
