class SessionModel {
  final String token;
  final String userId;

  SessionModel(this.token, this.userId);

  @override
  String toString() {
    return 'SessionModel{token: $token}, userId: $userId';
  }
}
