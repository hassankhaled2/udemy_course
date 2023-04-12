import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/shared/styles/colors.dart';

import '../../../models/post_model/Post_model.dart';
import '../../../models/social_app/cubit/cubit.dart';
import '../../../models/social_app/cubit/states.dart';

class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context,state){},
    builder: (context,state)
    {
      return ConditionalBuilder(
        condition:SocialCubit.get(context).posts.length>0
          &&SocialCubit.get(context).usermodel!=null,
        builder:(context)=>SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              margin:EdgeInsets.all(8),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(image:CachedNetworkImageProvider('https://img.freepik.com/free-photo/stunned-man-looks-with-great-surprisement-fear-aside-opens-mouth-widely-wears-hat-round-glasses_273609-38441.jpg?t=st=1679093086~exp=1679093686~hmac=1ca9cf4d074f15718957b491a28d1da8d676a7b01fafb2e2f861daa36367c776'),
                    fit: BoxFit.cover,
                    height: 200,
                    width:double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'communicate with friends',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),

            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
              separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
              itemCount:SocialCubit.get(context).posts.length,
            ),

            SizedBox(
              height:8,
            ),
          ],
        ),
      ),
        fallback: (context)=>Center(child: CircularProgressIndicator()),
      );
    },
    );
  }
  Widget buildPostItem(PostModel model ,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin:EdgeInsets.only(bottom: 10),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: CachedNetworkImageProvider('${model.image}'),
              ),
              SizedBox(width:15,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(

                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(
                            height: 1.4
                        ),
                      ),
                      SizedBox(width:5,),
                      Icon(
                        Icons.check_circle,
                        color: defaultColor,
                        size: 16,
                      )
                    ],
                  ),
                  Text(
                    '${model.dateTime}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.4,
                    ),
                  ),
                ],
              ),),
              SizedBox(width:15,),
              IconButton(onPressed:(){}, icon:Icon(
                Icons.more_horiz,
                size: 16,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10.0),
          //   child: Container(
          //     width: double.infinity,
          //
          //     child: Wrap(
          //       children: [
          //
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(bottom:10.0,top:5.0),
          //           child: Container(height:20,
          //               child: MaterialButton(onPressed: (){},minWidth:1.0,height: 25,padding:EdgeInsets.zero,child: Text('#software',style:Theme.of(context).textTheme.caption!.copyWith(color: defaultColor),))),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(bottom:10.0,top:5.0),
          //           child: Container(height:20,
          //               child: MaterialButton(onPressed: (){},minWidth:1.0,height: 25,padding:EdgeInsets.zero,child: Text('#software',style:Theme.of(context).textTheme.caption!.copyWith(color: defaultColor),))),
          //         ),
          //
          //
          //
          //
          //
          //       ],
          //
          //     ),
          //   ),
          // ),
          if(model.postImage!='')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15
            ),
            child: Container(
              height: 140,
              width:double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                  image: DecorationImage(
                    image:CachedNetworkImageProvider('${model.postImage}'),
                    fit: BoxFit.cover,

                  )
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.heart_broken,
                          size: 16.0,
                          color: Colors.yellow[800],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('${SocialCubit.get(context).Likes[index]}',style:Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    onTap: ()
                    {
                      SocialCubit.get(context).LikePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          Icon(Icons.comment,
                            size: 16.0,
                            color: Colors.yellow[800],
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('1 comment',style:Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                    onTap: ()
                    {

                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: CachedNetworkImageProvider('${SocialCubit.get(context).usermodel!.image}'),
                      ),
                      SizedBox(width:15,),
                      Text(
                        'write a comment.....',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          // height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  onTap:(){},
                ),

              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(Icons.heart_broken,
                      size: 16.0,
                      color: Colors.yellow[800],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('${SocialCubit.get(context).Likes[index]}',style:Theme.of(context).textTheme.caption,),
                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).LikePost(SocialCubit.get(context).postsId[index]);
                },
              ),

            ],
          )
        ],
      ),
    ),

  );
}
