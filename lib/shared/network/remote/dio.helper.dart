import 'package:dio/dio.dart';
class DioHelper
{
  static Dio?dio;
  static init()
  {
    dio =Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json',
          // 'lang':'en',
        },
      ),
    );
  }
  // static take care
  static Future<Response?>getData({
  required String url,
  dynamic? query,
  String lang ='en',
    String?token,
})async
  {
    dio?.options.headers={
      'lang':lang,
      'Authorization':token??'',
      // 'Content-Type': 'application/json',

      };
  return await dio?.get(url,queryParameters:query,);
  }
  static Future<Response?>PostData({
    required String url,
      dynamic? query,
    required dynamic? data,
    String lang ='en',
    String?token,
  })async
  {
    // dio?.options=BaseOptions(
    //   headers: {
    //     'lang':lang,
    //     'Authorization':token??'',
    //     // 'Content-Type': 'application/json',
    //   },
    // );
    dio?.options.headers={
      'lang':lang,
      'Authorization':token??'',
      // 'Content-Type': 'application/json',

    };
    return dio?.post(url,queryParameters: query,data: data);
  }
  static Future<Response?>PutData({
    required String url,
    dynamic? query,
    required dynamic? data,
    String lang ='ar',
    String?token,
  })async
  {
    // dio?.options=BaseOptions(
    //   headers: {
    //     'lang':lang,
    //     'Authorization':token??'',
    //     // 'Content-Type': 'application/json',
    //   },
    // );
    dio?.options.headers={
      'lang':lang,
      'Authorization':token??'',
      // 'Content-Type': 'application/json',

    };
    return dio?.put(url,queryParameters: query,data: data);
  }
}
//https://newsapi.org/
