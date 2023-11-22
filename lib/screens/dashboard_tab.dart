import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/text_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: TextWidget(
              text: 'Dashboard',
              fontSize: 18,
              fontFamily: 'Bold',
              color: Colors.blue,
            ),
            centerTitle: true,
          ),
          body: TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Schedules',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 25, left: 25),
                                child: Container(
                                  height: 150,
                                  width: 125,
                                  decoration: BoxDecoration(
                                    color: primary.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/doc1.png',
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            text: 'John Doe',
                                            fontSize: 14,
                                            fontFamily: 'Bold',
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextWidget(
                                            text:
                                                'Disease: Headache and Diarrhea',
                                            fontSize: 12,
                                            fontFamily: 'Regular',
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextWidget(
                                            text: 'October 25, 2023 at 5:30pm',
                                            fontSize: 12,
                                            fontFamily: 'Medium',
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          )),
    );
  }
}
