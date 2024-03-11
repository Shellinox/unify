import 'package:flutter/material.dart';
import 'package:unify/Screens/add_post_screen.dart';
import 'package:unify/Screens/contact_developer_screen.dart';
import 'package:unify/Screens/post_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static List<Widget> pages = [
    const PostScreen(),
    AddPostScreen(),
    const ContactDevScreen(),
  ];
  int selectedIndex = 0;

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts_rounded),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: ""),
        ],
        onTap: onTapped,
        currentIndex: selectedIndex,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
    );
  }
}
