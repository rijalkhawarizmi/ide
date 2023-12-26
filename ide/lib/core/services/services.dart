import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:ide/external/share.dart';
import 'package:ide/model/model_data.dart';
import 'package:ide/model/user_model.dart';
import 'package:intl/intl.dart';

class ServicesAPI {
  Dio _dio = Dio();
  String baseURL = "https://api-entrance-test.infraedukasi.com";

  Future<Response?> signIn(String email, String password) async {
    try {
      final response = await _dio.post('$baseURL/api/login',
          data: {"email": email, "password": password}, options: Options());

      return response;
    } on DioException catch (e) {
      throw e.response?.data["responseSystemMessage"];
    }
  }

  Future<Response?> getToken(String username, String password, String clientID,
      String clientSecret) async {
    try {
      final response = await _dio.post('$baseURL/oauth/token', data: {
        "grant_type": "password",
        "client_id": clientID,
        "client_secret": clientSecret,
        "username": username,
        "password": password,
        "scope": "*"
      });

      return response;
    } on DioException catch (e) {
      throw e.response?.data;
    }
  }

  Future<List<ModelData>?> fetchData() async {
    UserModel? userModel = await Shared.getShared();
    DateTime utcNow = DateTime.now().toUtc().toLocal();
    String formattedUtcNow =
        DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(utcNow);
    String payload =
        "path=/list-banner&verb=GET&token=Bearer ${userModel?.accessToken}&timestamp=${formattedUtcNow}Z&body=";

    String signature =
        generateSignature(userModel?.clientSecret ?? "", payload);

    try {
      final response = await _dio.get("$baseURL/api/list-banner",
          options: Options(headers: {
            "Authorization": "Bearer ${userModel?.accessToken}",
            "IDE-Timestamp": "${formattedUtcNow}Z",
            "IDE-Signature": signature,
            "Client-ID": "${userModel?.clientId}"
          }));

      if (response.statusCode == 200) {
        return response.data["responseData"].map<ModelData>((d) {
          return ModelData.fromJson(d);
        }).toList();
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data;
    }
  }

  

  String generateSignature(String consumerSecret, String payload) {
    List<int> secretBytes = utf8.encode(consumerSecret);
    List<int> payloadBytes = utf8.encode(payload);

    Hmac hmacSha256 = Hmac(sha256, secretBytes);

    Digest signature = hmacSha256.convert(payloadBytes);

    String base64Signature = base64.encode(signature.bytes);

    return base64Signature;
  }
}
