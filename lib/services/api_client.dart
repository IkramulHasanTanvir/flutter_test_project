import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import '../app/helpers/prefs_helper.dart';
import '../app/utils/app_constants.dart';
import 'api_urls.dart';
import 'error_response.dart';
import 'logger.dart';

final log = logger(ApiClient);

class ApiClient extends GetxService {
  static var client = http.Client();
  static const String noInternetMessage = "Can't connect to the internet!";
  static const int timeoutInSeconds = 60;
  static String bearerToken = "";

  // <==========================================> Get Data <======================================>
  static Future<Response> getData(
    String uri, {
    Map<String, String>? headers,
  }) async {
    bearerToken = await PrefsHelper.instance.getString(
      AppConstants.instance.accessToken,
    );

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      log.i('╔══════════════════════════════════════════╗');
      log.i('║          RESPONSE GET METHOD             ║');
      log.i('╚══════════════════════════════════════════╝');
      log.i(
        '|📍📍📍|-----------------[[ GET ]] method details start -----------------|📍📍📍|',
      );
      log.i('URL: $uri \n Headers: ${headers ?? mainHeaders}');

      http.Response response = await client
          .get(
            Uri.parse(ApiUrls.baseUrl + uri),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e, s) {
      log.e('🐞🐞🐞 Error in getData: ${e.toString()}');
      log.e('Stacktrace: ${s.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Post Data <======================================
  static Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    String bearerToken = await PrefsHelper.instance.getString(
      AppConstants.instance.accessToken,
    );

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      log.i(
        '|📍📍📍|-----------------[[ POST ]] method details start -----------------|📍📍📍|',
      );
      log.i('URL: $uri \n ${headers ?? mainHeaders} \n $body');

      http.Response response = await client
          .post(
            Uri.parse(ApiUrls.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      log.i('╔══════════════════════════════════════════╗');
      log.i('║         RESPONSE POST METHOD             ║');
      log.i('╚══════════════════════════════════════════╝');

      log.i("==========> Response Post Method: ${response.statusCode}");
      return handleResponse(response, uri);
    } catch (e, s) {
      log.e("🐞🐞🐞 Error in postData: ${e.toString()}");
      log.e("Stacktrace: ${s.toString()}");
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Handle Response <======================================
  static Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      log.e(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
      response0 = Response(
        statusCode: response0.statusCode,
        body: response0.body,
        statusText: errorResponse.message,
      );
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }

    log.i(
      '====> API Response: [${response0.statusCode}] $uri\n${response0.body}',
    );
    return response0;
  }
}
