import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/models/user/shop_app/search_model.dart';
import 'package:untitled13/modules/news_app/search/cubit/states.dart';
import 'package:untitled13/shared/components/constant.dart';
import 'package:untitled13/shared/network/remote/dio.helper.dart';

import '../../../../shared/network/end_point/end_point.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel?model;
  void Search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.PostData(url:search, data:{
      'text':text,
    },
      token: token,
    ).then((value) {
      model=SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}