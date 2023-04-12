class SocialUserModel
{
  String?name;
  String?email;
  String?phone;
  String?uId;
  String?image;
  String?Cover;
  String?bio;
  bool?isEmailVerified;
  SocialUserModel({
 this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.Cover,
    this.bio,
    this.isEmailVerified,
  });
  SocialUserModel.fromjson(Map<String,dynamic>json)
  {
email=json['email'];
name=json ['name'];
phone=json['phone'];
uId=json['uId'];
image=json['image'];
bio =json['bio'];
Cover =json['cover'];
isEmailVerified=json['isEmailVerified'];


}
Map<String,dynamic> ToMap()
  {
 return{
   'name':name,
   'email':email,
   'phone':phone,
   'uId':uId,
   'image':image,
   'cover':Cover,
   'bio':bio,
   'isEmailVerified':isEmailVerified,

 };
}
}