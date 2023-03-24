import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelo_mobile/pages/navpages/bookmarks_page.dart';
import 'package:travelo_mobile/pages/navpages/home_page.dart';
import 'package:travelo_mobile/pages/navpages/notification_page.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';
import 'package:travelo_mobile/pages/navpages/trips_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  List pages = [
    BookmarksPage(),
    TripsPage(),
    HomePage(),
    NotificationsPage(),
    ProfilePage(),
  ];
  int currentIndex = 2;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          elevation: 0,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xffEAAD5F),
          unselectedItemColor: Color(0xffBBBBBB),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
                label: "Bookmarks",
                icon: SvgPicture.asset("assets/icons/Bookmarks.svg",
                    color: currentIndex == 0
                        ? Color(0xffEAAD5F)
                        : Color(0xffBBBBBB))),
            BottomNavigationBarItem(
                label: "Trips",
                icon: SvgPicture.asset("assets/icons/Trips.svg",
                    color: currentIndex == 1
                        ? Color(0xffEAAD5F)
                        : Color(0xffBBBBBB))),
            BottomNavigationBarItem(
                label: "Home",
                icon: SvgPicture.asset("assets/icons/Home.svg",
                    color: currentIndex == 2
                        ? Color(0xffEAAD5F)
                        : Color(0xffBBBBBB))),
            BottomNavigationBarItem(
                label: "Notifications",
                icon: SvgPicture.asset("assets/icons/Notifications.svg",
                    color: currentIndex == 3
                        ? Color(0xffEAAD5F)
                        : Color(0xffBBBBBB))),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage("assets/images/userimage.png"),
                      fit: BoxFit.cover),
                  border: Border.all(
                      width: currentIndex == 4 ? 3 : 0,
                      color: Color(0xffFFD69D),
                      strokeAlign: BorderSide.strokeAlignCenter),
                ),
              ),
            ),
          ]),
    );
  }
}
