class ApiError {
  final String message;
  final int? statusCode;
  final dynamic errors; 

  ApiError({
    required this.message, 
    this.statusCode, 
    this.errors,
  });

  @override
  String toString() {
    
    return "ApiError(code: $statusCode, message: $message)";
  }

  
  String get firstErrorMessage {
    if (errors != null && errors is Map && (errors as Map).isNotEmpty) {
      var firstValue = (errors as Map).values.first;
      if (firstValue is List && firstValue.isNotEmpty) {
        return firstValue.first.toString();
      }
    }
    return message;
  }
}