import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/login/shop_login_screen.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:untitled13/shared/network/local/cache.helper.dart';

import '../../../shared/styles/colors.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller=PageController();

  List<BoardingModel>boarding=[
    BoardingModel(image: 'assests/images/OnBoarding1.jpg', title: 'On Board 1', body:'On Board 1 '),
    BoardingModel(image: 'assests/images/OnBoarding2.jpg', title: 'On Board 2', body:'On Board 2'),
    BoardingModel(image: 'assests/images/OnBoarding3.jpg', title: 'On Board 3', body:'On Board 3 '),
  ];
  bool isLast=false;
 void submit()
 {
   CacheHelper.savedata(key: 'onBoarding', value: true).then((value)
   {
     if(value!)
     {
       navigateAndFinish(context, ShopLoginScreen(),);
     }
   });
   navigateAndFinish(context, ShopLoginScreen(),);
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextbutton(function: submit,
              text:'skip'
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(

           children: [
             Expanded(
               child: PageView.builder(
                 physics: BouncingScrollPhysics(),
                 controller:boardcontroller,
                 onPageChanged: (int index)
                 {
                   if(index==boarding.length-1)
                   {
                    setState(() {
                      isLast=true;
                    });
                    print('last');
                   }else
                   {
                     print('not last');
                     // setState(() {
                     //   isLast=true;
                     // });
                   }
                 },
                 itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
                 itemCount: boarding.length,
               ),
             ),
             SizedBox(height: 40,),
             Row(
               children: [
                SmoothPageIndicator(controller: boardcontroller,effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.deepPurpleAccent,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0
                ), count: boarding.length),
                 Spacer(),
                 FloatingActionButton(onPressed:
                     (){
                   if(isLast)
                   {
                    submit();
                   }else
                   {
                     boardcontroller.nextPage(duration: Duration(milliseconds: 750), curve:Curves.fastLinearToSlowEaseIn);
                   }

                     },
                  // backgroundColor: Colors.deepOrange,
                   child: Icon(
                       Icons.arrow_forward_ios),
                 )

               ],
             ),
           ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0
        ),
      ),
    ],
  );
}
