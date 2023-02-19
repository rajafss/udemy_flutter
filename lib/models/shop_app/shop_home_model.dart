

class HomeModel{
 late bool status;
 late ShopDataModel data;


  HomeModel.fromJson(Map<String, dynamic> json){
    status= json['status'];
    data = (json['data'] != null ? ShopDataModel.fromJson(json['data']) : null)!;
  }
}

class ShopDataModel{
  List<BannerModel> banner = [];
  List<ProductModel> product = [];

  ShopDataModel.fromJson(Map<String, dynamic> json){

    json['banners'].forEach((element)
    {
      banner.add(element);
    });

    json['products'].forEach((element)
    {
      product.add(element);
    });


  }


}

class BannerModel
{
 late int id ;
  late String image;
  BannerModel.fromJson(Map<String, dynamic> json){
     id = json['id'];
     image = json['image'];
  }
}

class ProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldprice;
  late String image;
  late String name;
  ProductModel.fromJson(Map<String, dynamic> json){

    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    name = json['name'];
    image = json['image'];

  }
}