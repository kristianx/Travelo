import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/agency.dart';
import '../../providers/agency_provider.dart';
import '../../utils/util.dart';

// ignore: must_be_immutable
class ScaffoldWithNavBar extends StatefulWidget {
  String location;
  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  Agency _agency = Agency();
  late AgencyProvider _agencyProvider;
  @override
  void initState() {
    super.initState();
    _agencyProvider = context.read<AgencyProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpAgency =
        await _agencyProvider.getById(localStorage.getItem('agencyId') as int);
    setState(() {
      _agency = tmpAgency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          height: 90,
          child: Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/Logo.png",
                        width: 140,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      SvgPicture.asset('assets/icons/divider.svg'),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go("/dashboard");
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/Home.svg",
                              height: 20,
                              color: widget.location == '/dashboard'
                                  ? const Color(0xffEAAD5F)
                                  : const Color(0xffBBBBBB),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: widget.location == "/dashboard"
                                      ? Color(0xff454F63)
                                      : Color(0xff959595)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go("/offers");
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/Trips.svg",
                              height: 22,
                              color: widget.location == '/offers'
                                  ? const Color(0xffEAAD5F)
                                  : const Color(0xff959595),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Offers',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: widget.location == "/offers"
                                      ? Color(0xff454F63)
                                      : Color(0xff959595)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go("/profile");
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width:
                                        widget.location == "/profile" ? 3 : 0,
                                    color: const Color(0xffFFD69D),
                                    strokeAlign: BorderSide.strokeAlignCenter),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(200)),
                                image: DecorationImage(
                                    image: _agency.image == ""
                                        ? const AssetImage(
                                            "assets/images/imageHolder.png")
                                        : imageFromBase64String(_agency.image!)
                                            .image,
                                    fit: BoxFit.cover))),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          _agency.name ?? "Agency name",
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.location == "/profile"
                                  ? Color(0xff454F63)
                                  : Color(0xff959595),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: widget.child);
  }

  // void _goOtherTab(BuildContext context, int index) {
  //   if (index == _currentIndex && index != 2) return;
  //   GoRouter router = GoRouter.of(context);
  //   String location = tabs[index].initialLocation;

  //   setState(() {
  //     _currentIndex = index;
  //   });
  //   if (index == 2) {
  //     // context.push('/');
  //     router.go("/home");
  //   } else if (index == 4) {
  //     router.go("/profile");
  //   } else {
  //     router.go(location);
  //   }
  // }
}

// class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
//   final String initialLocation;

//   const MyCustomBottomNavBarItem(
//       {required this.initialLocation,
//       required Widget icon,
//       String? label,
//       Widget? activeIcon})
//       : super(icon: icon, label: label, activeIcon: activeIcon);
// }
class CustomAppBar extends PreferredSize {
  @override
  final Widget child;
  final double height;

  CustomAppBar({
    required this.height,
    required this.child,
  }) : super(child: child, preferredSize: Size.fromHeight(height));
}
