class UserModel
{
  String?name;
  String?id;
  String?phone;
  UserModel({
    this.name,
    this.id,
    this.phone,
  });
  UserModel.fromjson(Map<String,dynamic>json)
  {

    name=json ['name'];
    id=json['id'];
    phone=json['phone'];
  }
}