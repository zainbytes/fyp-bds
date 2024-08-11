import 'package:flutter/material.dart';
import 'package:fyp/view/findpage.dart';
import 'package:fyp/view/homepagebody.dart';
import 'package:fyp/view/settingpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  
  int currentScreen =1;
  List<Widget> screens =[
    FindPage(),HomepageBody(),SettingPage()
  ];

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //app bar
      appBar: AppBar(title: Text('Hello abc'),),

      //body 
      body: screens[currentScreen],


      //bottom navigation bar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentScreen=value;
          });
        },
        selectedIndex: currentScreen,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations:const [
          NavigationDestination(icon: Icon(Icons.manage_search_rounded), label: 'Find'),
          NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Setting'),
        ],),
    );
  }
}