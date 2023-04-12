import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/shared/components/components.dart';

import '../../../models/social_app/chat_details/chat_details.dart';
import '../../../models/social_app/cubit/cubit.dart';
import '../../../models/social_app/cubit/states.dart';
import '../../../models/social_app/social_user_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder:(context,index)=>myDivider(),
            itemCount:SocialCubit.get(context).users.length,
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildChatItem(SocialUserModel model,context)=> InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: CachedNetworkImageProvider
              ('${model.image}'),
          ),
          SizedBox(width:15,),
          Text(
            '${model.name}',
            style: TextStyle(
                height: 1.4
            ),
          ),
        ],
      ),
    ),
  );
}
