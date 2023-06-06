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
  List pages = [
    const BookmarksPage(),
    const TripsPage(),
    const HomePage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];
  int currentIndex = 2;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          elevation: 0,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xffEAAD5F),
          unselectedItemColor: const Color(0xffBBBBBB),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
                label: "Bookmarks",
                icon: SvgPicture.asset("assets/icons/Bookmarks.svg",
                    color: currentIndex == 0
                        ? const Color(0xffEAAD5F)
                        : const Color(0xffBBBBBB))),
            BottomNavigationBarItem(
                label: "Trips",
                icon: SvgPicture.asset("assets/icons/Trips.svg",
                    color: currentIndex == 1
                        ? const Color(0xffEAAD5F)
                        : const Color(0xffBBBBBB))),
            BottomNavigationBarItem(
                label: "Home",
                icon: SvgPicture.asset("assets/icons/Home.svg",
                    color: currentIndex == 2
                        ? const Color(0xffEAAD5F)
                        : const Color(0xffBBBBBB))),
            BottomNavigationBarItem(
                label: "Notifications",
                icon: SvgPicture.asset("assets/icons/Notifications.svg",
                    color: currentIndex == 3
                        ? const Color(0xffEAAD5F)
                        : const Color(0xffBBBBBB))),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/user-image.png"),
                      fit: BoxFit.cover),
                  border: Border.all(
                      width: currentIndex == 4 ? 3 : 1,
                      color: const Color(0xffFFD69D),
                      strokeAlign: BorderSide.strokeAlignCenter),
                ),
              ),
            ),
          ]),
    );
  }
}
