class HomeModel
{
  bool?status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status =json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}
class HomeDataModel
{
  List<BannerModel?>banners=[];
  List< ProductModel?>products=[];
  HomeDataModel.fromjson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element)
    {
      products.add(ProductModel.fromjson(element));
      //
    });
  }
}
class BannerModel
{
  int?id;
  String?image;
  BannerModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }

}
class ProductModel
{

  int?Id;
  dynamic?Price;
  dynamic?OldPrice;
  dynamic?Discount;
  String?image;
  String?Name;
  bool?InFavourites;
  bool?InCart;
  ProductModel.fromjson(Map<String,dynamic>json)
  {
    Id=json['id'];
    Price =json['price'];
    OldPrice=json['old_price'];
    Discount=json['discount'];
    image =json['image'];
    Name=json['name'];
    InFavourites=json['in_favorites'];
    InCart=json['in_cart'];





  }
}