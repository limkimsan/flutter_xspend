class ApiResponseUtil {
  static void handleResponse(response, successCallback, failureCallback) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      successCallback?.call();
      return;
    }
    failureCallback(ApiResponseUtil.handleError(response));
  }

  static String handleError(response) {
    switch (response.statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Something went wrong';
    }
  }
}