import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_divider/styled_divider.dart';

class WorkingOn extends StatefulWidget {
  const WorkingOn({super.key});

  @override
  WorkingOnState createState() => WorkingOnState();
}

class WorkingOnState extends State<WorkingOn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededee),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        backgroundColor: const Color(0xff21206a),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Working on',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        "assets/icons/splash_logo1.svg",
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 205,
          child: ListView.separated(
            itemCount: 15,
            itemBuilder: (context, index) {
              return ListTile(
                title: const Text(
                  "TechWyse Image Extensions 8th July 2022",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                subtitle: const Text(
                  "Paid | Search | TechWyse Internet Marketing",
                  style: TextStyle(
                    color: Color(0xFF717070),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    backgroundColor: const Color(0xFF8DC63F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.44, color: Color(0xFF8DC63F)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    minimumSize: const Size(50, 35),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const StyledDivider(
                color: Color(0xff9A9A9A),
                lineStyle: DividerLineStyle.dashed,
              );
            },
          ),

          // Column(
          //   children: [
          //
          //   ],
          // ),
        ),
      ),
    );
  }
}
