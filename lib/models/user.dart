class UserModel {
  late String name;
  late String phone;
  late String about;
  late String image;
  late String uId;

  UserModel({
    required this.name,
    required this.phone,
    required this.about,
    required this.image,
    required this.uId,
  });

  UserModel.fromJson(json) {
    name = json['name'];
    phone = json['phone'];
    about = json['about'];
    image = json['image'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      name: 'name',
      phone: 'phone',
      about: 'about',
      image: 'image',
      uId: 'uId',
    };
  }
}
