class Character {
  late int id;
  late String name;
  late String image;
  late String nickName;
  late String birthday;
  late String status;
  late List<dynamic> jobs;
  late List<dynamic> betterCallSaulAppearance;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.nickName,
    required this.birthday,
    required this.status,
    required this.jobs,
    required this.betterCallSaulAppearance,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
      id: json['char_id'],
      name: json['name'],
      image: json['img'],
      nickName: json['nickname'],
      birthday: json['birthday'],
      status: json['status'],
      jobs: json['occupation'],
      betterCallSaulAppearance: json['better_call_saul_appearance']);
}
