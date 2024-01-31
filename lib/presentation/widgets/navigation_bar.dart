import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ValueNotifier<int> screenChangeNotifier = ValueNotifier(0);

class BottomNavigationDrawer extends StatelessWidget {
  const BottomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: screenChangeNotifier, builder: (context, int newIndex, _) {
      return BottomNavigationBar(
      currentIndex: newIndex,
      onTap: (value) {
        screenChangeNotifier.value = value;
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      items: const [
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house,size: 20,),label: 'Home',),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.peopleGroup,size: 20,),label: 'Community'),
      BottomNavigationBarItem(icon: Icon(Icons.add,size: 20,),label: 'Create',),
      BottomNavigationBarItem(icon: Icon(Icons.chat,size: 20,),label: 'Chats'),
      BottomNavigationBarItem(icon: Icon(Icons.public,size: 20,),label: 'All'),
    ]);
    },);
  }
}