import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:suit_media_test/core/constraint/variables.dart';
import 'package:http/http.dart' as http;
import 'package:suit_media_test/data/models/user_model.dart';

class AuthRemoteDataSource {
  final url = Variable.baseUrl;

  Future<Either<String, List<Data>>> fetchUser(String page) async {
    final response = await http.get(
      Uri.parse("$url/users?page=$page&per_page=10"),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final UserModel userModel = UserModel.fromMap(jsonData);
      final List<Data> users = userModel.data;
      return Right(users);
    } else {
      return const Left("Error Fetching Data");
    }
  }
}
