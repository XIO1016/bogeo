class Login {
  final String password;
  final String user_id;

  Login(this.password, this.user_id);

  Login.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        user_id = json['user_id'];

  Map<String, dynamic> toJson() => {
        'password': password,
        'user_id': user_id,
      };
  void updateUserData() {}
}
