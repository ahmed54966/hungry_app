import 'package:dio/dio.dart';
import 'package:hungry/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Make sure you are connected to the server");

      case DioExceptionType.badResponse:
        
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return ApiError(message: "The order has been cancelled");

      default:
        return ApiError(message:"An unexpected error occurred, please try again later.");
    }
  }

  static ApiError _handleBadResponse(DioException error) {
    
    if (error.response?.data != null) {
      final data = error.response!.data;
      

      if (data is Map && data.containsKey('message')) {
        return ApiError(message: data['message']);
      }
    }

    
    switch (error.response?.statusCode) {
      case 400: return ApiError(message: "بيانات خاطئة (Bad Request)");
      case 401: return ApiError(message: "غير مصرح لك، يرجى تسجيل الدخول");
      case 404: return ApiError(message: "الصفحة أو المورد غير موجود");
      case 500: return ApiError(message: "خطأ في السيرفر الداخلي");
      default: return ApiError(message: "خطأ غير معروف: ${error.response?.statusCode}");
    }
  }
}