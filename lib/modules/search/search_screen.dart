
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_api/cubit/cubit.dart';
import 'package:udemy_flutter/shared/compenents/compenent.dart';

import '../../layout/news_api/cubit/states.dart';

class SearchScreen extends StatefulWidget
{
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          var list = NewsCubit.get(context).search;

          return  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(

                  controller: searchControler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    //setState(() {
                      NewsCubit.get(context).getSearch(value);
                      print(value);
                   // });


                  },
                  validator: (String? value)  {
                    if(value!.isEmpty){

                      return 'search must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articlBuilder(list, context,isSearch: true))
            ],
          );

        },
      ),

    );
  }
}
