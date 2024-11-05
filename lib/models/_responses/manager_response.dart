class ManagerResponse<T> {
  String? errorMessage;
  T? response;

  bool get hasError => errorMessage != null;

  ManagerResponse({
    this.errorMessage,
    this.response,
  });

  @override
  String toString() {
    return 'ManagerResponse{errorMessage: $errorMessage, response: $response}';
  }
}
