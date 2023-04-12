import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/social_app/cubit/cubit.dart';
import '../../../models/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';



class NewsPostScreen extends StatelessWidget {
 var textControrllor=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder: (context,state)
      {
        return  Scaffold(
          appBar:PreferredSize(
            preferredSize:  const Size.fromHeight(50),
            child:
            defaultAppBar(context: context,title: 'create Post',
              actions: [defaultTextbutton(function:
                  ()
              {
                var now =DateTime.now();
                if(SocialCubit.get(context).PostImage==null)
                {
                  SocialCubit.get(context).CreatePostImage(dateTime:now.toString(), text: textControrllor.text);
                }else
                {
                  SocialCubit.get(context).UploadPostImage(dateTime: now.toString(), text: textControrllor.text);
                }
              }, text:'Post')],),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children:
            [
              if(state is SocialCreatePostLoadingState)
              LinearProgressIndicator(),
              if(state is SocialCreatePostLoadingState)
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('https://img.freepik.com/free-photo/portrait-surprised-young-african-man_171337-7403.jpg?w=1060&t=st=1679093288~exp=1679093888~hmac=63056bf2db1150aae14df1fef1432db718db5f4c569ec9c2ee1c987c706c21d1'),
                  ),
                  SizedBox(width:15,),
                  Expanded(child: Text(
                    'Hassan Khaled',
                    style: TextStyle(
                        height: 1.4
                    ),
                  ),),
                ],
              ),
              Expanded(
                child: TextFormField(
                    controller: textControrllor,
                  decoration: InputDecoration(
                      hintText:'What is your in mind.....'
                  ),
                ),
              ),
              SizedBox(height: 20,),
              if(SocialCubit.get(context).PostImage!=null)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [

                  Container(
                    // alignment: AlignmentDirectional.topCenter,
                    height: 140,
                    width:double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image:FileImage(SocialCubit.get(context).PostImage!) as ImageProvider,
                          fit: BoxFit.cover,

                        )
                    ),
                  ),
                  IconButton(onPressed:
                      ()
                  {
                    SocialCubit.get(context).removePostImage();
                  },
                    icon:CircleAvatar(
                        radius: 16.0,
                        child: Icon(Icons.close)),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(onPressed:
                        ()
                    {
                      SocialCubit.get(context).getPostImage();
                    }, child:
                    Row(
                      children: [
                        Icon(Icons.add_a_photo_outlined),
                        SizedBox(width:5,),
                        Text('Add Photo'),
                      ],
                    ),),
                  ),
                  Expanded(
                    child: TextButton(onPressed: (){}, child:
                 Text('# Tags')),
                  ),
                ],
              )
            ],),
          ),
        );
      },
    );
  }

}
