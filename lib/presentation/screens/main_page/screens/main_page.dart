
import 'package:connected/presentation/screens/all_post/screens/all_post_screen.dart';
import 'package:connected/presentation/screens/chats/screens/chat_screen.dart';
import 'package:connected/presentation/screens/community/screens/community_screen.dart';
import 'package:connected/presentation/screens/create_discussion/screens/create_discussion_screen.dart';
import 'package:connected/presentation/screens/home/screens/home_screen.dart';
import 'package:connected/presentation/widgets/app_bar.dart';
import 'package:connected/presentation/widgets/drawer_items.dart';
import 'package:connected/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

late BuildContext mainPageContext;
class MainPage extends StatelessWidget {

   const MainPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    mainPageContext = context;
    final pages = [
      const HomeScreen(),
       const CommunityScreen(),
      const CreateDiscussion(),
      const ChatScreen(),
      const AllPostsScreen()
    ];
    return ValueListenableBuilder(
      valueListenable: screenChangeNotifier,
      builder: (context, int index, _) {
        return Scaffold(
          appBar: const CustomAppBar(),
          drawer: const SafeArea(
            child: Drawer(
              child: DrawerItems(),
            ),
          ),
          body: pages[index],
          bottomNavigationBar: const BottomNavigationDrawer(),
        );
      },
    );
  }
}
