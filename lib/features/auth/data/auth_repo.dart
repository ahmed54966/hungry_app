import 'package:dio/dio.dart';
import 'package:hungry/features/auth/data/auth_model.dart';
import 'package:hungry/network/api_error.dart';
import 'package:hungry/network/api_exeptions.dart';
import 'package:hungry/network/api_services.dart';
import 'package:hungry/utilies/pref_helpers.dart';

class AuthRepo {
  final ApiServices apiServices = ApiServices();
  bool isGuest = false;
  AuthModel? _currentUser;

  Future<AuthModel?> login(String email, String password) async {
    try {
      final response = await apiServices.post("/login", {
        "email": email, 
        "password": password
      });

      if (response is ApiError) {
        throw response; 
      }
      
      final user = AuthModel.fromJson(response["data"]);

      
      if (user.token != null) {
        await PrefHelpers.saveToken(user.token!);
      }
      isGuest = false;
      _currentUser = user;
      return user;

    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
    
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
      
    }
  }

  Future<AuthModel?> register(String email, String password,String name) async {
    try {
      final response = await apiServices.post("/register", {
        "email": email, 
        "password": password,
        "name": name
      });

      if (response is ApiError) {
        throw response; 
      }
      
      final user = AuthModel.fromJson(response["data"]);

      
      if (user.token != null) {
        await PrefHelpers.saveToken(user.token!);
      }
      isGuest = false;
      _currentUser = user;
      return user;

    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
    
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<AuthModel?> getProfileData() async {
  try {

    final token = await PrefHelpers.getToken();
    if(token == null || token == "Guest"){
      return null;
    }

    final response = await apiServices.get("/profile");

    if (response is ApiError) {
      throw response; 
    }
    
    final user = AuthModel.fromJson(response["data"]);
    _currentUser = user;
    return user;

  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  } catch (e) {
    if (e is ApiError) rethrow; 
    
    print("Error in getProfileData Repo: $e");
    throw ApiError(message: "Error parsing profile data");
  }
}
Future<AuthModel?> updateProfileData(String email, String name, String address, String visa, String? imagePath) async {
  try {
    
    Map<String, dynamic> dataMap = {
      "email": email,
      "name": name,
      "address": address,
      "visa": visa, 
    };

    
    if (imagePath != null && imagePath.isNotEmpty) {
      dataMap["image"] = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
    }

    final formData = FormData.fromMap(dataMap);

    final response = await apiServices.post("/update-profile", formData);

    if (response is ApiError) {
      throw response;
    }

    
    if (response["data"] != null) {
      return AuthModel.fromJson(response["data"]);
    } else {
      
      return AuthModel.fromJson(response);
    }

  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  } catch (e) {
    if (e is ApiError) rethrow;
    print("Parsing Error Details: $e"); 
    throw ApiError(message: "Error parsing profile data: $e");
  }
}

Future<AuthModel?> logOut() async {
    try {
      final response = await apiServices.post("/logout", {
        
      });

      if (response is ApiError) {
        throw response; 
      }
      
      final user = AuthModel.fromJson(response["data"]);

      
      if (user.token != null) {
        await PrefHelpers.clearToken();
      }
      isGuest = true;
      _currentUser = null;
      return user;

    } on DioException catch (e) {
      
      throw ApiExceptions.handleError(e);
    } catch (e) {
    
      if (e is ApiError) rethrow; 
      throw ApiError(message: "Unexpected error: ${e.toString()}");
      
    }
  }

  Future<AuthModel?> autoLogin() async {
    
    final token = await PrefHelpers.getToken();
    if(token == null || token == "Guest"){
      isGuest = true;
    _currentUser = null;
    return null;
    }
    isGuest = false;
    try{
      final user = await getProfileData();
      _currentUser = user;
      return user;
    }catch(e){
      await PrefHelpers.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  Future<AuthModel?> contenueAsGuest() async {
  isGuest=true;
  _currentUser = null;
  await PrefHelpers.saveToken("Guest");
  return null;

  }

AuthModel? get currentUser => _currentUser;
bool get isLogedin => !isGuest && _currentUser != null;

}