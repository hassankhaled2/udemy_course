class ChangeFavoritesModel
{
  bool?status;
  String?message;
  // String?data;
  ChangeFavoritesModel.fromjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    // data= ChangeFavoritesModel.fromjson(json['data']);

  }
}