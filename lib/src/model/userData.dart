class UserData {
  late String id;
  late String password;
  late int age;
  late int gender;

  UserData(
      {required this.id,
      required this.password,
      required this.age,
      required this.gender});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    age = json['age'];
    gender = json['gender'];
  }

  // 이거는 return이 있기 때문에 getter와 같은 역할
  // fromJson에서 UserData에 값을 담고 이 getter를 통해 데이터를 호출
  // UserData.toJson()으로 호출
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['age'] = this.age;
    data['gender'] = this.gender;

    return data;
  }
}
