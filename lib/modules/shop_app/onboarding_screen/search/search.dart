
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/news_app/search/cubit/cubit.dart';
import 'package:untitled13/modules/news_app/search/cubit/states.dart';
import 'package:untitled13/shared/components/components.dart';


class SearchShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formkey =GlobalKey<FormState>();
    var searchController =TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                   defaultFormField(type: TextInputType.text,
                       validate: (String?value)
                       {
                         if(value!.isEmpty)
                         {
                        return 'enter text to search';
                         }
                          return null;
                       },
                       onSubmit: (String?Text)
                       {
                         SearchCubit.get(context).Search(Text!);
                       },
                       label:'Search',
                       prefix: Icons.search,
                       controller:searchController),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,IsOldPrice: false),
                        separatorBuilder: (context,index)=>myDivider(),
                        itemCount:SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
