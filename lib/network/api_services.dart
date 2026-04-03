import 'package:dio/dio.dart';
import 'package:hungry/network/api_exeptions.dart';
import 'package:hungry/network/dio.dart';

class ApiServices {
  final DioClient _dioClint = DioClient();

  Future<dynamic> get(String endPoint)async{
    try {
      // ignore: non_constant_identifier_names
      final Response = await _dioClint.dio.get(endPoint);
      return Response.data;
    }on DioException catch (e){
      return ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> post(String endPoint, dynamic body)async{
    try {
      // ignore: non_constant_identifier_names
      final Response = await _dioClint.dio.post(endPoint,data: body);
      return Response.data;
    }on DioException catch (e){
      return ApiExceptions.handleError(e);
    }
  }

    Future<dynamic> put(String endPoint, dynamic body)async{
    try {
      // ignore: non_constant_identifier_names
      final Response = await _dioClint.dio.put(endPoint,data: body);
      return Response.data;
    }on DioException catch (e){
      return ApiExceptions.handleError(e);
    }
  }

    Future<dynamic> delete(String endPoint,dynamic body)async{
    try {
      // ignore: non_constant_identifier_names
      final Response = await _dioClint.dio.delete(endPoint,data: body);
      return Response.data;
    }on DioException catch (e){
      return ApiExceptions.handleError(e);
    }
  }
}