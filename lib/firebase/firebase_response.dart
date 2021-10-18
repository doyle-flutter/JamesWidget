class FirebaseResponse{
  final FirebaseResponseErrorDetail error;
  final result;
  const FirebaseResponse({
    required this.result,
    required this.error
  });
}

enum FirebaseResponseError{
  Error,
  Timeout,
  None
}
class FirebaseResponseErrorDetail{
  FirebaseResponseError errorCheck;
  var errorData;
  FirebaseResponseErrorDetail({
    required this.errorData,
    required this.errorCheck
  });
}