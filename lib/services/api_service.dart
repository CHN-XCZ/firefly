import 'package:dio/dio.dart';
import '../models/user.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  Future<User> fetchUser() async {
    final response = await _dio.get('/users/1');
    return User.fromJson(response.data);
  }
}
