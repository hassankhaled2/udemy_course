import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/layout/news_app/cubit/cubit.dart';
import 'package:untitled13/layout/news_app/cubit/states.dart';
import 'package:untitled13/modules/news_app/search/cubit/states.dart';
import 'package:untitled13/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
 var Searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        var list =NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(),
          body:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller:Searchcontroller,
                  type: TextInputType.text,
                  onChanged: (value)
                  {
                   NewsCubit.get(context).getSearch(value);
                  },
                  validate:(String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: "search",
                  prefix: Icons.search,
                ),
              ),
              if(state is SearchSuccessState)
              Expanded(child: articleBuilder(list, context,isSeacrh: true))
            ],
          ),
        );
      },

    );
  }
}
