import 'package:pro_deals_admin/utils/imports.dart';

class ApiService {
  static Future<dynamic> getApi(
    Uri url,
    BuildContext ctx, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await get(
        url,
        headers: headers,
      ).timeout(Apis.timeout);
      return _processResponse(response, ctx);
    } on SocketException {
      ShowToast.toast(
        msg: 'No Internet connection',
        ctx: ctx,
      );
    } on TimeoutException {
      ShowToast.toast(
        msg: 'Request timed out, please try again later',
        ctx: ctx,
      );
      return null;
    } catch (e) {
      ShowToast.toast(
        msg: 'Unexpected error occurred: $e',
        ctx: ctx,
      );
      return null;
    }
  }

  static Future<dynamic> multipartApi(
    Uri url,
    BuildContext ctx,
    dynamic imageParamName,
    dynamic imagePath, {
    Map<String, String>? body,
    String method = 'POST',
  }) async {
    try {
      var request = MultipartRequest(
        method,
        url,
      );

      if (body != null) {
        request.fields.addAll(body);
      }
      if (imageParamName is String && imagePath is String) {
        if (imageParamName.isNotEmpty) {
          request.files
              .add(await MultipartFile.fromPath(imageParamName, imagePath));
        }
      } else if (imageParamName is List && imageParamName.isNotEmpty) {
        for (int i = 0; i < imageParamName.length; i++) {
          request.files.add(
              await MultipartFile.fromPath(imageParamName[i], imagePath[i]));
        }
      }
      request.headers.addAll(Apis.headersValue);

      StreamedResponse response1 = await request.send().timeout(Apis.timeout);
      String s = await response1.stream.bytesToString();
      return _processResponse(
          Response(
            s,
            response1.statusCode,
            request: response1.request,
          ),
          ctx);
    } on SocketException {
      ShowToast.toast(
        msg: 'No Internet connection',
        ctx: ctx,
      );
      return null;
    } on TimeoutException {
      ShowToast.toast(
        msg: 'Request timed out, please try again later',
        ctx: ctx,
      );
      return null;
    } catch (e) {
      ShowToast.toast(
        msg: 'Unexpected error occurred: $e',
        ctx: ctx,
      );
      return null;
    }
  }

  static Future<dynamic> putApi(
    Uri url,
    BuildContext ctx, {
    Map<String, dynamic>? body,
  }) async {
    try {
      var response;
      if (body == null) {
        response = await put(
          url,
        ).timeout(Apis.timeout);
      } else {
        response = await put(
          url,
          body: jsonEncode(body),
          headers: Apis.headersValue,
        ).timeout(Apis.timeout);
      }
      return _processResponse(response, ctx);
    } on SocketException {
      ShowToast.toast(
        msg: 'No Internet connection',
        ctx: ctx,
      );
    } on TimeoutException {
      ShowToast.toast(
        msg: 'Request timed out, please try again later',
        ctx: ctx,
      );
      return null;
    } catch (e) {
      ShowToast.toast(
        msg: 'Unexpected error occurred: $e',
        ctx: ctx,
      );
      return null;
    }
  }

  static Future<dynamic> deleteApi(
    Uri url,
    BuildContext ctx,
  ) async {
    try {
      final response = await delete(
        url,
      ).timeout(Apis.timeout);
      return _processResponse(response, ctx);
    } on SocketException {
      ShowToast.toast(
        msg: 'No Internet connection',
        ctx: ctx,
      );
    } on TimeoutException {
      ShowToast.toast(
        msg: 'Request timed out, please try again later',
        ctx: ctx,
      );
      return null;
    } catch (e) {
      ShowToast.toast(
        msg: 'Unexpected error occurred: $e',
        ctx: ctx,
      );
      return null;
    }
  }

  static Future<dynamic> deleteApiBody(
    Uri url,
    BuildContext ctx,
    Map<String, List<String>> body,
  ) async {
    try {
      final response = await delete(
        url,
        headers: Apis.headersValue,
        body: jsonEncode(body),
      ).timeout(Apis.timeout);

      return _processResponse(response, ctx);
    } on SocketException {
      ShowToast.toast(
        msg: 'No Internet connection',
        ctx: ctx,
      );
    } on TimeoutException {
      ShowToast.toast(
        msg: 'Request timed out, please try again later',
        ctx: ctx,
      );
      return null;
    } catch (e) {
      ShowToast.toast(
        msg: 'Unexpected error occurred: $e',
        ctx: ctx,
      );
      return null;
    }
  }

  static Future<dynamic> postApi(
    Uri url,
    BuildContext ctx, {
    dynamic body,
  }) async {
    try {
      var response;
      if (body != null) {
        response = await post(
          url,
          headers: Apis.headersValue,
          body: jsonEncode(body),
        ).timeout(Apis.timeout);
      } else {
        response = await post(
          url,
          headers: Apis.headersValue,
        ).timeout(Apis.timeout);
      }

      return _processResponse(response, ctx);
    } on SocketException {
      ShowToast.toast(
        msg: 'No Internet connection',
        ctx: ctx,
      );
      return null;
    } on TimeoutException {
      ShowToast.toast(
        msg: 'Request timed out, please try again later',
        ctx: ctx,
      );
      return null;
    } catch (e) {
      ShowToast.toast(
        msg: 'Unexpected error occurred: $e',
        ctx: ctx,
      );
      return null;
    }
  }

  static dynamic _processResponse(Response response, BuildContext ctx) {
    switch (response.statusCode) {
      case 200 || 201:
        return jsonDecode(response.body);
      case 400:
        if (jsonDecode(response.body)['message'] != null) {
          ShowToast.toast(
            msg: '${jsonDecode(response.body)['message'] ?? ""}',
            ctx: ctx,
          );
          return null;
        }
        throw BadRequestException('Bad request: ${response.body}');
      case 401:
      case 403:
        throw UnauthorisedException('Unauthorized: ${response.body}');
      case 500:
        if (jsonDecode(response.body)['message'] != null) {
          ShowToast.toast(
            msg: '${jsonDecode(response.body)['message'] ?? ""}',
            ctx: ctx,
          );
          return null;
        }
      default:
        ShowToast.toast(
          msg:
              'Error occurred while communicating with server. Status code: ${response.statusCode}',
          ctx: ctx,
        );
        return null;
    }
  }
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class UnauthorisedException implements Exception {
  final String message;

  UnauthorisedException(this.message);
}
