

import 'package:ksdpl/common/storage_service.dart';

class MyHeader{
  static Future<Map<String, String>> getHeaders() async {
    String? token = StorageService.get(StorageService.TOKEN);

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
    };
  }

  static Future<Map<String, String>> getHeaders2() async {
    String? token = StorageService.get(StorageService.TOKEN);

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
      'Content-Type': 'multipart/form-data'
    };
  }



  static Future<Map<String, String>> getHeaders3() async {
    String? token = StorageService.get(StorageService.TOKEN);

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
      'Content-Type': 'application/json'
    };
  }
}