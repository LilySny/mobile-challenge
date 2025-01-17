import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mobile_challenge/home/domain/usecases/find_user_by_id.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/shared_mocks.dart';
import '../../mocks/mock_github_service.dart';


void main() {
  FindUserById usecase;
  MockGithubService mockGithubService;

  setUp(() {
    mockGithubService = MockGithubService();
    usecase = FindUserById(mockGithubService);
  });

  test(
    'should get user in the repository',
    () async {
      final response = UserModel.fromJson(jsonDecode(mockUser));
      when(mockGithubService.findById(33629714))
          .thenAnswer((_) async => response);

      final result = await usecase.execute(33629714);

      expect(result, response);
    },

  );
}
