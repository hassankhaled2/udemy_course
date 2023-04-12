import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled13/shared/cubit/cubit.dart';

import '../../modules/news_app/webview/web_view.dart';
import '../../modules/shop_app/onboarding_screen/shop_login/cubit/cubit.dart';
import '../styles/colors.dart';
// import 'package:cached_network_image/cached_network_image.dart';

Widget defaultButton(
        {double width = double.infinity,
        bool isUpperCase = true,
        double radius = 0.0,
        Color background = Colors.deepPurpleAccent,
        required Function function,
        required String text}) =>Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
Widget defaultTextbutton({
  required Function function,
  required String text,
})=> TextButton(
    onPressed:(){
      function();
      },
    child: Text(text.toUpperCase()),
);
Widget defaultFormField(
        {TextEditingController? controller,
        required TextInputType type,
        Function(String)? onSubmit,
        Function(String)? onChanged,
        GestureTapCallback? onTap,
        bool isPassword = false,
        required String? Function(String?)? validate,
        String? label,
        IconData? prefix,
        IconData? suffix,
        final VoidCallback? suffixPressed,
        bool? obscureText}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget defaultAppBar({
  required BuildContext context,
  String?title,
  required List<Widget>actions,
})=>AppBar(
  leading: IconButton(
    onPressed:(){
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_left,
    ),
  ),
  titleSpacing:5.0,
  title: Text(title!),
  actions: actions,
);
Widget BuildTasksItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.check_box,
              ),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );
Widget taskBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => BuildTasksItem(tasks[index], context),
        separatorBuilder: (context, index) =>  myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet,Please Add some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article,context)=> InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children:
  
      [
  
        Container(
  
          width:120.0 ,
  
          height:120.0,
  
          decoration:BoxDecoration(borderRadius: BorderRadius.circular(10.0),
  
            image:DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
  
  
            ),
  
          ),
  
  
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              mainAxisSize: MainAxisSize.min,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(



                  child: Text(
  
                    '${article['title']}',
  
                     style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 4,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(color: Colors.grey),
  
                )
  
  
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);
Widget articleBuilder(list, context,{isSeacrh=false})=>ConditionalBuilder(
  condition:list.length>0,
  builder: (context) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index],context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount:list.length,
      ),
  fallback: (context) => isSeacrh?Container():Center(child: CircularProgressIndicator()),
);
void navigateTo(context,widget)=>Navigator.push(context, 
MaterialPageRoute(builder: (context)=>widget));
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute
      (builder:
        (context)=>widget),
        (route)
    // page you  can not return it
    {
      return false;
    });
void ShowToast({
  required String text,
  required ToastStates state,
})=>
    Fluttertoast.showToast(

    msg:text,
    toastLength:Toast.LENGTH_LONG,
    //andorid
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 10,
    //ios
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARNING}
Color ?chooseToastColor(ToastStates state)
{
  Color?color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}
Widget buildListProduct( model,context,{bool IsOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                // fit: BoxFit.fill,
                height: 120,
                width: 120,
                // fit: BoxFit.cover,
              ),
              if(model.discount!=0&& IsOldPrice)
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 5.0) ,
                  color: Colors.red,
                  child: Text(
                    'Discount' ,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,

                    ),
                  ),
                )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        height: 1.3
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price!.toString(),
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
                      if( model.discount!=0 && IsOldPrice)
                        Text(
                          model.oldPrice.toString(),
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
                          backgroundColor:ShopCubit.get(context).favorites[model.id]!?defaultColor:Colors.grey,
                          child: Icon(Icons.favorite_border,
                            color: Colors.white,
                            size: 14,),
                        ),onPressed:()
                      {
                        ShopCubit.get(context).changefavourite(model.id);
                        // print(model.Id);
                      },)
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
