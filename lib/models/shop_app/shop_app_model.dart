

class ShopUserModel
{
  late bool status;
  late String message;
  late  UserData data;
  ShopUserModel({required this.status, required this.message, required this.data});

  ShopUserModel.fromJson(Map<String, dynamic> json){

    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {

  late int id;
late String name;
   late String email;
   late String phone;
   late String image;
   late int credit;
   late int points;
   late String token;

  // UserData
  //     ({
  // required  this.id,
  //   required this.name,
  //   required  this.email,
  //   required this.phone,
  //   required  this.image,
  //   required  this.credit,
  //   required  this.points,
  //   required this.token
  // });
  UserData.fromJson(Map<String, dynamic> json){

    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    credit = json['credit'];
    points = json['points'];
    token = json['token'];

  }

}