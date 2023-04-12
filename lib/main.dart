import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/layout/news_app/news_layout.dart';
import 'package:untitled13/layout/shop_app/shop_layout.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/onborading_screen.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/login/shop_login_screen.dart';
import 'package:untitled13/modules/social_app/social_register/social_login_screen.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:untitled13/shared/components/constant.dart';
import 'package:untitled13/shared/cubit/cubit.dart';
import 'package:untitled13/shared/cubit/states.dart';
import 'package:untitled13/shared/network/local/cache.helper.dart';
import 'package:untitled13/shared/network/remote/dio.helper.dart';
import 'package:untitled13/shared/styles/block%20observer.dart';
import 'package:untitled13/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/social_screen_layout/social_screen_layout.dart';
import 'models/social_app/cubit/cubit.dart';
import 'modules/shop_app/onboarding_screen/shop_login/cubit/cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// print('on background message');
// print(message.data.toString());
// ShowToast(text: 'on background message', state: ToastStates.SUCCESS);
// }
void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // var token=await FirebaseMessaging.instance.getToken();
  // //بنبعت to token notification
  // print(token);
  // FirebaseMessaging.onMessage.listen((event)
  // {
  // print(event.data.toString());
  // ShowToast(text: 'on message on app', state: ToastStates.SUCCESS);
  // });
  // // لو فاتح ال App
  // FirebaseMessaging.onMessageOpenedApp.listen((event)
  // {
  //   print(event.data.toString());
  //   ShowToast(text: 'on message Opened app', state: ToastStates.SUCCESS);
  //   //لو ال App فى ال background
  // });
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getdata(key: 'isDark');
  Widget widget;
  // bool? onBoarding =CacheHelper.getdata(key: 'onBoarding');
  // token=CacheHelper.getdata(key: 'token');
  uId=CacheHelper.getdata(key: 'uId');
  // print(token);
  // if(onBoarding!=null)
  // {
  //   if(token!=null) widget=ShopLayoutScreen();
  //   else widget=ShopLoginScreen();
  // }else
  // {
  //   widget=OnBoardingScreen();
  // }
  // print(onBoarding);
  if(uId !=null)
  {
    widget=SocialLayout();
  }else
  {
    widget=SocialLoginScreen();
  }
  // FirebaseMessaging messaging =FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  // FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
  runApp(MyApp(isDark: isDark
    ,startwidget:widget,));
}
class MyApp extends StatelessWidget {
   final bool? isDark;
   final Widget? startwidget;

  MyApp({this.isDark, this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSport()..getScience(),),
        BlocProvider(   create: (BuildContext context) =>AppCubit()..changeAppMode(
            fromshared: isDark),

        ),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoryData()..getFavouriteData()..getUserData(),),
        BlocProvider(   create: (BuildContext context) =>SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
       listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:LightTheme,
            darkTheme: darkTheme,
            themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            // themeMode:ThemeMode.da,
            home:NewsLayout(),
          );
        },
      ),
    );
  }
//startwidget
}
