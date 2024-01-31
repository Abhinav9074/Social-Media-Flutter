import 'package:connected/application/bloc/user_search_bloc/user_search_bloc.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_event.dart';
import 'package:connected/presentation/screens/search_page/widgets/searched_discussions.dart';
import 'package:connected/presentation/screens/search_page/widgets/searched_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              //search bar
              TextFormField(
                onChanged: (value){
                  if(value.isNotEmpty){
                    BlocProvider.of<UserSearchBloc>(context).add(UserSearchingEvent(searchValue: value));
                  }else{
                    BlocProvider.of<UserSearchBloc>(context).add(NoSearchValueEvent());
                  }
                },
                  decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              )),

              //tabs 
              const TabBar(tabs: [
                Tab(text: "Discussions",),
                Tab(text: "People",),
              ]),

              //Tab bar view

              const Expanded(
                child: TabBarView(children: [
                  SearchedDiscussion(),
                  SearchedUsers(),
                ]),
              )
            ],
          ),
        ));
  }
}
