import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
import 'package:fyp/view/findpage.dart';
import 'package:fyp/view/homepagebody.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/settingpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentScreen = 1;
  List<Widget> screens = [const FindPage(), const HomepageBody(), const SettingPage()];
  String title='loading.....';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    var uid = Auth().currentUser!.uid;
    AppUserStore().readUserFromStore(uid).then((user) => setState(() {
      title=user!.fullName;
    }));
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      
      //app bar
      appBar:  CustomAppbar(title: 'Hello $title',),

      //body
      body: screens[currentScreen],

      //bottom navigation bar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentScreen = value;
          });
        },
        indicatorColor: Colors.red.shade400,
        selectedIndex: currentScreen,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.manage_search_rounded),
              selectedIcon:
                  Icon(Icons.manage_search_rounded, color: Colors.white),
              label: 'Find'),
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Setting',
            selectedIcon: Icon(
              Icons.settings_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


