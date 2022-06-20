import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mobile_challenge/home/domain/usecases/find_all_users.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_github_service.dart';

void main() {
  FindAllUsers usecase;
  MockGithubService mockGithubService;
  final _mockResult = '''{
   "data":[
      {
         "login":"LilySny",
         "id":33629714,
         "avatar_url":"https://avatars.githubusercontent.com/u/33629714?v=4",
         "location":"Campinas, São Paulo - Brazil",
         "email":"liviacastilholi@gmail.com",
         "bio":""
      },
      {
         "login":"LilySny2",
         "id":33629715,
         "avatar_url":"https://avatars.githubusercontent.com/u/33629714?v=4",
         "location":"Campinas, São Paulo - Brazil",
         "email":"liviacastilholi2@gmail.com",
         "bio":""
      }
   ]
} ''';

  setUp(() {
    mockGithubService = MockGithubService();
    usecase = FindAllUsers(mockGithubService);
  });

  test(
    'should get users in the repository',
    () async {
      final data = jsonDecode(_mockResult)["data"] as List;
      final response = data.map((e) => UserModel.fromJson(e)).toList();
      when(mockGithubService.findAll("Lily"))
          .thenAnswer((_) async => response);

      final result = await usecase.execute("Lily");

      expect(result, response);
    },
  );
}
