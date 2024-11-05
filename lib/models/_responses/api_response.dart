class ApiResponse<T> {
  String? errorMessage;
  T? response;
  var responseAux;
  bool authError = false;

  bool get isValid => errorMessage == null && response != null;

  ApiResponse({
    this.errorMessage,
    this.response,
    this.responseAux,
    this.authError = false,
  }) {
    if (authError) {
      errorMessage = '';
      response = null;
    }
  }
}
