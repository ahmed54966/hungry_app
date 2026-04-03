import 'package:dio/dio.dart';
import 'package:hungry/features/product/data/cart_model.dart';
import 'package:hungry/network/api_error.dart';
import 'package:hungry/network/api_exeptions.dart';
import 'package:hungry/network/api_services.dart';

class CartRepo {
    ApiServices apiServices = ApiServices();

  Future<CartModel?> addToCart(CartRequestModel cartItem ) async {
    try {
      final response = await apiServices.post("/cart/add", cartItem);

      if (response is ApiError) {
        throw response; 
      }


    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
    
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
      
    }
    return null;
  }

  Future<CartModel?> getCart(CartRequestModel cartItem ) async {
    try {
      final response = await apiServices.get("/cart");

      if (response is ApiError) {
        throw response; 
      }


    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
    
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
      
    }
    return null;
  }

}