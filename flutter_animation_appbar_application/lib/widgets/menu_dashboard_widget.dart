// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  var currentPage = 0;
  var _currentIndex = 0;
  final TextStyle systemGreyColor =
      const TextStyle(color: CupertinoColors.systemGrey4, fontSize: 12);
  final TextStyle menuStyle =
      const TextStyle(color: Colors.white, fontSize: 20);
  final Color _backgroundColor = const Color(0xFF343442);
  final Color _backgroundContainer = const Color.fromRGBO(57, 57, 70, 1);
  late double ekranYuksekligi, ekranGenisligi;
  bool menuAcikMi = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _menuOffsetAnimation = Tween(
            begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        borderRadius: const Radius.circular(20),
        iconSize: 30.0,
        selectedColor: const Color(0xff040307),
        strokeColor: const Color(0x30040307),
        unSelectedColor: CupertinoColors.white,
        backgroundColor: _backgroundContainer,
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.show_chart_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.share_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.notifications_none_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.person_outline_sharp),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [menuOlustur(context), dashBoardOlustur(context)],
        ),
      ),
    );
  }

  Widget menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 90,
                child: CircleAvatar(
                  child: Image.asset(
                    "assets/person.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Roger Hoffmann",
                    style: menuStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 46.0),
                    child: Text(
                      "San Francisco, CA",
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.folder_copy_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Dashboard",
                    style: menuStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.message_outlined,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Messages",
                    style: TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.business_outlined,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Utility Bills",
                    style: TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.transfer_within_a_station_outlined,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Fund Transfer",
                    style: TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.location_city_outlined,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Branches",
                    style: TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikMi ? 0.4 * ekranGenisligi : 0,
      right: menuAcikMi ? -0.4 * ekranGenisligi : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Material(
            borderRadius: menuAcikMi ? BorderRadius.circular(40) : null,
            elevation: 8,
            color: _backgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (menuAcikMi) {
                              _controller.reverse();
                            } else {
                              _controller.forward();
                            }
                            menuAcikMi = !menuAcikMi;
                          });
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "My Cards",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      children: [
                        pageViewContainer(0, "\$12.432.32",
                            "**** **** **** 1505", "Laurel Bailey", "05/20"),
                        pageViewContainer(1, "\$34.321.29",
                            "**** **** **** 4444", "Mathilda Box", "09/21"),
                        pageViewContainer(2, "\$31.234.56",
                            "**** **** **** 3212", "Alexa Yannis", "08/23"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ".",
                        style: TextStyle(
                            color:
                                currentPage == 0 ? Colors.blue : Colors.white,
                            fontSize: 40,
                            fontWeight:
                                currentPage == 0 ? FontWeight.bold : null),
                      ),
                      Text(
                        ".",
                        style: TextStyle(
                            color:
                                currentPage == 1 ? Colors.blue : Colors.white,
                            fontSize: 40,
                            fontWeight:
                                currentPage == 1 ? FontWeight.bold : null),
                      ),
                      Text(
                        ".",
                        style: TextStyle(
                            color:
                                currentPage == 2 ? Colors.blue : Colors.white,
                            fontSize: 40,
                            fontWeight:
                                currentPage == 2 ? FontWeight.bold : null),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 16),
                        child: Text(
                          "Transaction",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.wallet,
                          color: CupertinoColors.systemGrey4,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 16),
                        child: Text(
                          "Today",
                          style: TextStyle(color: CupertinoColors.systemGrey4),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8),
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _backgroundContainer),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                  backgroundColor: CupertinoColors.black,
                                  child: Icon(
                                    Icons.apple_outlined,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Macbook Pro 15",
                                      style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 60),
                                    child: Text(
                                      "Apple",
                                      style: TextStyle(
                                          color: CupertinoColors.systemGrey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 70,
                              ),
                              const Text(
                                "-2499 \$",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8),
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _backgroundContainer),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    backgroundColor: CupertinoColors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("assets/upwork.png"),
                                    )),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Incoming Transfer",
                                      style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 70),
                                    child: Text(
                                      "Upwork",
                                      style: TextStyle(
                                          color: CupertinoColors.systemGrey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              const Text(
                                "+499 \$",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 16),
                        child: Text(
                          "Yesterday",
                          style: TextStyle(color: CupertinoColors.systemGrey4),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8),
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _backgroundContainer),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                  backgroundColor: CupertinoColors.black,
                                  child: Icon(
                                    Icons.apple_outlined,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Airpods 2th Gen",
                                      style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 65),
                                    child: Text(
                                      "Apple",
                                      style: TextStyle(
                                          color: CupertinoColors.systemGrey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 85,
                              ),
                              const Text(
                                "-199 \$",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8),
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _backgroundContainer),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    backgroundColor: CupertinoColors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child:
                                          Image.asset("assets/starbucks.png"),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.0),
                                      child: Text(
                                        "Coffee",
                                        style: TextStyle(
                                            color: CupertinoColors.white,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Starbucks",
                                        style: TextStyle(
                                            color: CupertinoColors.systemGrey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 120,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Text(
                                  "-19.50 \$",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8),
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _backgroundContainer),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    backgroundColor: CupertinoColors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("assets/paypal.png"),
                                    )),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Money Transfer",
                                      style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 60),
                                    child: Text(
                                      "Paypal",
                                      style: TextStyle(
                                          color: CupertinoColors.systemGrey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 77,
                              ),
                              const Text(
                                "+300 \$",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Container pageViewContainer(int currentPage, String currentBalance,
    String cardNumber, String cardHolder, String expires) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromRGBO(27, 122, 254, 1)),
    width: 100,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16),
              child: Text(
                "Current Balance",
                style: TextStyle(color: CupertinoColors.systemGrey4),
              ),
            ),
            SizedBox(
              width: 130,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16.0,
              ),
              child: Text(
                "Bank",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "X",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16),
              child: Text(
                currentBalance,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16),
              child: Text(
                cardNumber,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16),
              child: Text(
                "Card Holder",
                style:
                    TextStyle(color: CupertinoColors.systemGrey4, fontSize: 12),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Expires",
                style:
                    TextStyle(color: CupertinoColors.systemGrey4, fontSize: 12),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                cardHolder,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              expires,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}
