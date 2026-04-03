import 'package:dio/dio.dart';
import 'package:hungry/utilies/pref_helpers.dart';

class DioClient { 
  final Dio _dio = Dio(
    BaseOptions(
      
      baseUrl: "https://sonic-zdi0.onrender.com/api", 
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json", 
      },
      
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelpers.getToken();
          if (token != null && token.isNotEmpty && token != "Guest") {
            
            options.headers["Authorization"] = "Bearer $token"; 
          }
          return handler.next(options);
        },
        
        onError: (DioException e, handler) {
          print("DIO ERROR [${e.response?.statusCode}] => ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}