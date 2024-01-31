import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/screens/profile/screens/self_profile_view.dart';
import 'package:connected/presentation/screens/search_page/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQueryCustom.appBarHeight(context),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }, icon: const Icon(Icons.menu))
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const SearchScreen()));}, icon: const Icon(Icons.search)),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    FontAwesomeIcons.bell,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const ProfileScreen()));
                      }, icon: const CircleAvatar(child: Icon(Icons.account_circle),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 100);
}
