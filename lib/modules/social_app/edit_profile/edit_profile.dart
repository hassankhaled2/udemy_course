

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../models/social_app/cubit/cubit.dart';
import '../../../models/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var PhoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
       listener:(context,state)
       {

       } ,
      builder: (context,state)
      {

        var usermodel=SocialCubit.get(context).usermodel;
        var ProfileImage=SocialCubit.get(context).ProfileImage;
        var CoverImage=SocialCubit.get(context).CoverImage;
        nameController.text=usermodel!.name!;
        bioController.text=usermodel.bio!;
        PhoneController.text=usermodel.phone!;
        return  Scaffold(
            appBar:PreferredSize(
              child: defaultAppBar(context: context,title: 'New Post',actions: [
                defaultTextbutton(function:
                    ()
                {
                   SocialCubit.get(context).UpdateUser(name: nameController.text, phone: PhoneController.text, bio: bioController.text);
                    }, text: 'update'),
                SizedBox(
                  width: 15.0,
                ),
              ]
              ),

              preferredSize:  const Size.fromHeight(100),),
          body: SingleChildScrollView(
            child: Column(children:
            [
              if(state is SocialUserUpdateLoadingState)
              LinearProgressIndicator(),
              if(state is SocialUserUpdateLoadingState)
              SizedBox(
                width: 15.0,
              ),
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            // alignment: AlignmentDirectional.topCenter,
                            height: 140,
                            width:double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight:Radius.circular(4.0),

                                ),
                                image: DecorationImage(
                                  image:CoverImage==null? NetworkImage(
                                      '${usermodel.Cover}'):FileImage(CoverImage) as ImageProvider,
                                  fit: BoxFit.cover,

                                )
                            ),
                          ),
                        IconButton(onPressed:
                            ()
                        {
                          SocialCubit.get(context).getCoverImage();
                        },
                          icon:CircleAvatar(
                            radius: 16.0,
                            child: Icon(Icons.camera_alt)),),
                        ],
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                   Stack(
                     alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius:60,
                            backgroundImage:
                           ProfileImage==null?AssetImage('${usermodel.image}',):FileImage(ProfileImage)as ImageProvider,
                          ),
                        ),
                        IconButton(onPressed: () {
                                     SocialCubit.get(context).getProfileImage();
                        },icon:CircleAvatar(
                            radius: 16.0,
                            child: Icon(Icons.camera_alt)),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              if(SocialCubit.get(context).ProfileImage!=null||SocialCubit.get(context).CoverImage!=null)
              Row(
                children:
                [
                  if(SocialCubit.get(context).ProfileImage!=null)
                  Expanded(child:
                  Column(
                    children: [
                      defaultButton(function:()
                      {
                        SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone:PhoneController.text, bio:bioController.text);
                      }, text:'Upload Profile'
                      ),
                      if(state is SocialUserUpdateLoadingState)
                        SizedBox(
                          width: 5.0,
                        ),
                      if(state is SocialUserUpdateLoadingState)
                        LinearProgressIndicator(),
                    ],
                  ),
                  ),
                  SizedBox(
                     width: 5.0,
                  ),
                  if(SocialCubit.get(context).CoverImage!=null)
             Expanded(child:
               Column(

                 children: [
                   defaultButton(function:()
                   {
                     SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone:PhoneController.text, bio:bioController.text);
                   }, text:'Upload Cover'

                       ),
                   if(state is SocialUserUpdateLoadingState)

                     SizedBox(
                     width: 5.0,
                   ),
                   if (state is SocialUserUpdateLoadingState)
                   LinearProgressIndicator(),
                 ],
               ),
             ),
                ],
              ),
              if(SocialCubit.get(context).ProfileImage!=null||SocialCubit.get(context).CoverImage!=null)
              SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                controller: nameController,
                  type: TextInputType.name, validate: (String?value){if(value!.isEmpty)
              {
                return 'name must not be empty';
              }
              return null;
              }, label: 'Name',prefix:Icons.person),

              SizedBox(
                height: 10.0,
              ),

              defaultFormField(
                  controller: bioController,
                  type: TextInputType.text, validate: (String?value){if(value!.isEmpty)
              {
                return 'bio must not be empty';
              }
              return null;
              }, label: 'Bio',prefix:Icons.info_outlined),
              SizedBox(
                height: 10.0,
              ),
              defaultFormField(
                  controller: PhoneController,
                  type: TextInputType.phone, validate: (String?value){if(value!.isEmpty)
              {
                return 'phone must not be empty';
              }
              return null;
              }, label: 'Phone',prefix:Icons.phone),


            ],
            ),
          ),
        );
      },
    );
  }
}
