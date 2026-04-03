import 'package:dio/dio.dart';
import 'package:hungry/features/cart/data/get_cart_model.dart';
import 'package:hungry/network/api_error.dart';
import 'package:hungry/network/api_exeptions.dart';
import 'package:hungry/network/api_services.dart';

class GetCartRepo {
  ApiServices apiServices = ApiServices();

  Future<CartResponseModel?> getCart() async {
    try {
      final response = await apiServices.get("/cart");

      
      if (response is ApiError) {
        throw response; 
      }


      if (response != null) {
        
        return CartResponseModel.fromJson(response);
      }

      return null;

    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<CartResponseModel?> deleteCart(int id) async {
    try {
      final response = await apiServices.delete("/cart/remove/$id", {});

    if (response is ApiError) throw response;

    return response != null ? CartResponseModel.fromJson(response) : null;

    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }
}