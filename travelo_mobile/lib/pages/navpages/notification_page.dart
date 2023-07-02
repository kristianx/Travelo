import 'package:flutter/material.dart';
import 'package:travelo_mobile/widgets/NotificationCard.dart';
import 'package:travelo_mobile/widgets/PageHeader.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          PageHeader(
            pageName: "Notifications",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Today",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    const NotificationCard(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "01. April",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    const NotificationCard(),
                    const NotificationCard(),
                    const NotificationCard(),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
