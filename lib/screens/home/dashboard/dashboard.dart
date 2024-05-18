import 'package:flutter/material.dart';
import 'package:untitled/screens/home/dashboard/report/attendance_report.dart';

import '../../../widgets/bottomNavBar/navbar_item.dart';
import 'checkedin/checkin_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.index});

  final int? index;
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    if (widget.index != null) {
      _currentIndex = widget.index!;
    }

    _pageController = PageController(initialPage: _currentIndex);

    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const CheckInPage(),
      const AttendanceReport(),
      Container(color: Colors.blue),
      Container(color: Colors.yellow),
    ];

    return PopScope(
      canPop:
          true, //_currentIndex== 0, // Disable back gesture if not on the first page
      onPopInvoked: (bool didPop) {
        // if (!didPop) {
        //   // Navigate to the first page if the back gesture was blocked
        //   _pageController.jumpToPage(0);
        // }
      },
      child: Scaffold(
        extendBody: true,
        body: PageView.builder(
          // physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: 4, // Number of pages
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  NavbarItem(
                    isSelected: _currentIndex == 0 ? true : false,
                    toolTip: 'Check Out',
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                        _pageController.jumpToPage(_currentIndex);
                      });
                    },
                    svgImage: "assets/icons/let_me_checkin_dark.svg",
                    text: 'CHECK OUT',
                  ),
                  const SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      color: Color(0xffe7e7e7),
                    ),
                  ),
                  NavbarItem(
                    isSelected: _currentIndex == 1 ? true : false,
                    toolTip: 'Attendance',
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                        _pageController.jumpToPage(_currentIndex);
                      });
                    },
                    svgImage: "assets/icons/attendance_history_dark.svg",
                    text: 'ATTENDANCE',
                  ),
                  const SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      color: Color(0xffe7e7e7),
                    ),
                  ),
                  NavbarItem(
                    isSelected: _currentIndex == 2 ? true : false,
                    toolTip: 'Time Sheet',
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                        _pageController.jumpToPage(_currentIndex);
                      });
                    },
                    svgImage: "assets/icons/time_sheet_dark.svg",
                    text: 'TIME SHEET',
                  ),
                  const SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      color: Color(0xffe7e7e7),
                    ),
                  ),
                  NavbarItem(
                    isSelected: _currentIndex == 3 ? true : false,
                    toolTip: 'Working On',
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                        _pageController.jumpToPage(_currentIndex);
                      });
                    },
                    svgImage: "assets/icons/working_on_dark.svg",
                    text: 'WORKING ON',
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
