import 'package:binge_prime/screens/comming_soon.dart';
import 'package:binge_prime/screens/downloads.dart';
import 'package:binge_prime/screens/more.dart';
import 'package:binge_prime/screens/search.dart';
import 'package:binge_prime/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor:,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Mdi.homeOutline, size: 28),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Mdi.searchWeb, size: 28),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Mdi.playBoxMultiple, size: 28),
            title: Text("Comming Soon"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Mdi.download, size: 28),
            title: Text("Downloads"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Mdi.menu, size: 28),
            title: Text("More"),
          )
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            WelcomeScreen(),
            SearchScreen(),
            CommingSoonScreen(),
            DownloadScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}
