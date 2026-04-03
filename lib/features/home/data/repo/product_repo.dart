import 'package:dio/dio.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/side_options_model.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';
import 'package:hungry/network/api_error.dart';
import 'package:hungry/network/api_exeptions.dart';
import 'package:hungry/network/api_services.dart'; 

class ProductRepo {
  
  final ApiServices apiServices = ApiServices();

  Future<List<ProductModel>> getProductData() async {
    try {
      final response = await apiServices.get("/products");

      if (response is ApiError) {
        throw response;
      }
    
      if (response["data"] != null) {
        return (response["data"] as List)
            .map((e) => ProductModel.fromJson(e)) 
            .toList();
      }
      
      return []; 

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      print("Error in getProductData Repo: $e");
      throw ApiError(message: "Error parsing product data");
    }
  }

  Future<List<ToppingModel>> getToppingData() async {
    try {
      final response = await apiServices.get("/toppings");

      if (response is ApiError) {
        throw response;
      }
    
      if (response["data"] != null) {
        return (response["data"] as List)
            .map((e) => ToppingModel.fromJson(e)) 
            .toList();
      }
      
      return []; 

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      print("Error in getProductData Repo: $e");
      throw ApiError(message: "Error parsing product data");
    }
  }

  Future<List<SideOptionsData>> getSideOptionsData() async {
    try {
      final response = await apiServices.get("/side-options");

      if (response is ApiError) {
        throw response;
      }
    
      if (response["data"] != null) {
        return (response["data"] as List)
            .map((e) => SideOptionsData.fromJson(e)) 
            .toList();
      }
      
      return []; 

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      print("Error in getProductData Repo: $e");
      throw ApiError(message: "Error parsing product data");
    }
  }

  Future<List<ProductModel>> getSearchData() async {
    try {
      final response = await apiServices.get("/products");

      if (response is ApiError) {
        throw response;
      }
    
      if (response["data"] != null) {
        return (response["data"] as List)
            .map((e) => ProductModel.fromJson(e)) 
            .toList();
      }
      
      return []; 

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      print("Error in getProductData Repo: $e");
      throw ApiError(message: "Error parsing product data");
    }
  }

}
