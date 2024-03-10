import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/Screens/add_post_screen.dart';
import 'package:unify/Screens/contact_developer_screen.dart';
import 'package:unify/Screens/post_screen.dart';
import 'package:unify/provider/theme_provider.dart';

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
  static const List<String> pagetitle = [
    "Posts",
    "Add Post",
    "Contact us",
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
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text("Change Theme"),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                  Navigator.of(context).pop();
                },
              ),

            ],
          ),
        ),
      ),
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
      appBar: AppBar(
        title: Text(pagetitle[selectedIndex]),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
    );
  }
}
