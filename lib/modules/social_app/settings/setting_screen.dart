import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/social_app/edit_profile/edit_profile.dart';
import 'package:untitled13/shared/components/components.dart';

import '../../../models/social_app/cubit/cubit.dart';
import '../../../models/social_app/cubit/states.dart';

class SocialSettingScreen extends StatelessWidget {
  const SocialSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var usermodel=SocialCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        // alignment: AlignmentDirectional.topCenter,
                        height: 140,
                        width:double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight:Radius.circular(4.0),

                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                             '${usermodel!.Cover}'),
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius:60,
                        backgroundImage:
                        NetworkImage('${usermodel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${usermodel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${usermodel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '40K',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Follower',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '3',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () {  }, child: Text('Add Photos'),
                    
                  )),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: ()
                  {
                    navigateTo(context,EditProfileScreen());
                  }, child:Icon(Icons.edit,size: 16,)),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: 
                      ()
                  {
                    FirebaseMessaging.instance.subscribeToTopic('announcement');
                  }, child: Text('subscribe'),
                  ),
                  SizedBox(width: 20,),
                  OutlinedButton(onPressed: ()
                  {
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                  }, child: Text('unsubscribe'),

             ),
             ]
              ),
            ],
          ),
        );
      },
    );
  }
}
