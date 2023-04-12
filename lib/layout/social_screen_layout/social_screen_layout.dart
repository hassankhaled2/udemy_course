
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/social_app/newpost/new_post.dart';
import 'package:untitled13/shared/components/components.dart';

import '../../models/social_app/cubit/cubit.dart';
import '../../models/social_app/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        if(state is SocialNewPostState)
        {
         navigateTo(context,NewsPostScreen());
        }
      },
      builder: (context,state)
      {
        var cubit=SocialCubit.get(context);
        return  Scaffold(
          appBar:AppBar(
            title: Text(cubit.title[cubit.CurrentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon:Icon(Icons.notifications_none)),
              IconButton(onPressed: (){}, icon:Icon(Icons.search))
            ],
          ),
          body:cubit.screens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            onTap: (index){
            cubit.changeBottomNav(index);
          },
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon:Icon(Icons.chat),label: 'chat'),
              BottomNavigationBarItem(icon:Icon(Icons.add),label: 'Upload'),
              BottomNavigationBarItem(icon:Icon(Icons.location_on),label: 'location'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings')
            ],
          ),


        );
      },
    );
  }
}
// ConditionalBuilder(
//   condition: SocialCubit.get(context).model!=null,
//   builder: (context)
//   {
//     var model =!FirebaseAuth.instance.currentUser!.emailVerified;
//     print(model);
//     return Column(
//       children: [
//         if(!model)
//         Container(
//           color: Colors.amber.withOpacity(.6),
//           height: 50,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal:15),
//             child: Row(
//               children: [
//                 Icon(Icons.info_outline),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Expanded(child: Text('Please verify your email')),
//                 SizedBox(
//                   height:15,
//                 ),
//                 defaultTextbutton(
//                   // width: 80,
//                     function: ()
//                     {
//                       FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value)
//                       {
//                         ShowToast(text:'check your mail',state:ToastStates.SUCCESS,);
//                       }).catchError((error){
//
//                       });
//                     },
//                     text:'send'
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   },
//   fallback: (context)=>Center(child: CircularProgressIndicator()),
// ),