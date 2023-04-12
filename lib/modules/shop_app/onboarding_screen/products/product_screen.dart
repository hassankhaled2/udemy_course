


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:untitled13/shared/styles/colors.dart';

import '../../../../models/user/shop_app/category_model.dart';
import '../../../../models/user/shop_app/home_model1.dart';
import '../shop_login/cubit/cubit.dart';
import '../shop_login/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  // const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
      (
      listener:(context,state)
      {
        if(state is ShopSuccessChangeFavouriteState)
        {
        if(!state.model.status!)
        {
         ShowToast(text: state.model.message!, state:ToastStates.ERROR);
        }
        }
      },
      builder: (context,state)
    {
      return ConditionalBuilder(
        condition: ShopCubit.get(context).homemodel!=null&&ShopCubit.get(context).categoriesModel!=null,
        builder:(context)=> productsBuilder(ShopCubit.get(context).homemodel,ShopCubit.get(context).categoriesModel,context),
        fallback: (context)=>Center(child: CircularProgressIndicator()),
      );
    },
    );
  }
  Widget productsBuilder(HomeModel?Model,CategoriesModel?categoriesModel,context)=>SingleChildScrollView(
    physics:BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
        horizontal: 10.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CarouselSlider(items:Model!.data!.banners.map((e)=>
                Image(
                  image: NetworkImage('${e?.image}'),
                  width: double.infinity,fit: BoxFit.cover,)
              ,).toList(),
               options:CarouselOptions
                 (
                 height:310,
                 initialPage: 0,
                 viewportFraction: 1.0,
                 enableInfiniteScroll: true,
                 reverse: false,
                 autoPlay: true,
                 autoPlayInterval: Duration(seconds: 3),
                 autoPlayAnimationDuration: Duration(seconds: 1),
                 autoPlayCurve: Curves.fastOutSlowIn,
                 scrollDirection: Axis.horizontal,
               ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Categories',
                style: TextStyle(
                    fontSize:12,
                    fontWeight:FontWeight.w800
                ),
              ),
              Container(
                height: 100.0,
                child: ListView. separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection:Axis.horizontal,
                    itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data[index]!),
                    separatorBuilder: (context,index)=>SizedBox(
                      width: 20.0,
                    ),
                    itemCount: categoriesModel!.data!.data.length,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight:FontWeight.w800
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                // color: Colors.blue,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1/1.7,

                  children:List.generate(
                      Model.data!.products.length, (index) => buildGridProduct( Model.data!.products[index],context)

                  ),
                ),
              ),

            ],
          ),
        ),
      ],

),
  );
  Widget buildCategoryItem(DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image!),
        height:80,
        width: 80,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(
         model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

    ],
  );
  Widget  buildGridProduct(ProductModel?model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage(model!.image!),
               height: 180,
              width: double.infinity,
              // fit: BoxFit.cover,
            ),
            if(model.Discount!=0)
            Container(
              padding:EdgeInsets.symmetric(horizontal: 5.0) ,
              color: Colors.red,
              child: Text(
                  'Discount',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,

                ),
              ),
            )
          ],
        ),
        Text(
            model.Name!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black,
            fontSize: 14.0,
            height: 1.3
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${model.Price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: defaultColor,
                        fontSize: 14.0,
                        height: 1.3,

                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.Discount!=0)
                  Text(
                    '${model.OldPrice.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      height: 1.3,
                      decoration: TextDecoration.lineThrough,

                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.Id]!?defaultColor:Colors.grey,
                      child: Icon(Icons.favorite_border,
                  color: Colors.white,
                  size: 14,),
                    ),onPressed:()
                  {
                    ShopCubit.get(context).changefavourite(model.Id);
                    print(model.Id);
                  },)
                ],
              ),

            ],
          ),
        ),
      ],
    ),
  );

}
