import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static final ApiService _instance = ApiService.internal();

  factory ApiService() => _instance;

  ApiService.internal();

  Future<Map<String, dynamic>> request({
    required ApiMethod method,
    required String query,
    Api api = Api.wishlist,
    Map<String, dynamic>? body,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {
      String currentUrl = api.getUrl + query;
      log('${method.getString} $currentUrl');

      Response response = await Dio()
          .request(
            currentUrl,
            data: jsonEncode(body),
            options: Options(
              method: method.getString,
              receiveTimeout: 120 * 1000,
              sendTimeout: 120 * 1000,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 501;
              },
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          )
          .timeout(duration);
      if (response.data == null) {
        response.data = {'emptyError': 'Empty'};
      } else if (response.data is List) {
        response.data = {"data": response.data};
      } else if (response.data is String) {
        response.data = {"data": response.data};
      }

      _printReturnValue(
        method.getString,
        api,
        query,
        body?.toString() ?? '{}',
        response.data.toString(),
      );
      return response.data;
    } on TimeoutException catch (e) {
      Map<String, dynamic> res = {'connection': e.toString()};
      _printReturnValue(
        method.getString,
        api,
        query,
        body?.toString() ?? '{}',
        res.toString(),
      );
      return res;
    } catch (e) {
      Map<String, dynamic> res = {'error': e.toString()};
      _printReturnValue(
        method.getString,
        api,
        query,
        body?.toString() ?? '{}',
        res.toString(),
      );
      return res;
    }
  }

  void _printReturnValue(
    String type,
    Api api,
    String query,
    String body,
    String response,
  ) {
    log("\n---------------------------------------------------"
        "\n=============METHOD: $type"
        "\n=============URL: ${api.getUrl + query}"
        "\n=============Query string: $query"
        "\n=============Body: ${body.toString()}"
        "\n=============Response: ${response.toString()}"
        "\n---------------------------------------------------\n");
  }
}

enum Api { products, wishlist }

enum ApiMethod { get, post, put, delete, patch }

extension ApiExtension on Api {
  String get name => describeEnum(this);

  String get getUrl {
    switch (this) {
      case Api.products:
        return 'https://dummyjson.com/';
      case Api.wishlist:
        return 'http://18.229.128.247:8091/diletta/';

      default:
        throw Exception();
    }
  }
}

extension ApiMethodExtension on ApiMethod {
  String get getString {
    switch (this) {
      case ApiMethod.get:
        return 'GET';
      case ApiMethod.post:
        return 'POST';
      case ApiMethod.put:
        return 'PUT';
      case ApiMethod.delete:
        return 'DELETE';
      case ApiMethod.patch:
        return 'PATCH';
    }
  }
}
