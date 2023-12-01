import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Patients')
                              .where('nurseId',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .where('day',
                                  isEqualTo: selectedDay.day
                                      .toString()
                                      .padLeft(2, '0'))
                              .where('month',
                                  isEqualTo: selectedDay.month.toString())
                              .where('year',
                                  isEqualTo: selectedDay.year.toString())
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }

                            final data = snapshot.requireData;
                            return SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemCount: data.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 25,
                                          left: 25),
                                      child: Container(
                                        height: 160,
                                        width: 125,
                                        decoration: BoxDecoration(
                                          color: primary.withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.account_box,
                                              size: 75,
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
                                                  text:
                                                      '${data.docs[index]['fname']} ${data.docs[index]['mname'][0].toString().toUpperCase()}. ${data.docs[index]['lname']}',
                                                  fontSize: 14,
                                                  fontFamily: 'Bold',
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextWidget(
                                                  text:
                                                      'Description: ${data.docs[index]['desc']}',
                                                  fontSize: 12,
                                                  fontFamily: 'Regular',
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextWidget(
                                                  text:
                                                      '${data.docs[index]['bday']}',
                                                  fontSize: 12,
                                                  fontFamily: 'Medium',
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextWidget(
                                                  text:
                                                      '${data.docs[index]['time']}',
                                                  fontSize: 12,
                                                  fontFamily: 'Medium',
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextWidget(
                                                  text:
                                                      'Status: ${data.docs[index]['isAssigned'] ? 'Assigned' : 'Not Assigned'}',
                                                  fontSize: 12,
                                                  fontFamily: 'Medium',
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Patients')
                                                        .doc(
                                                            data.docs[index].id)
                                                        .delete();
                                                  },
                                                  child: TextWidget(
                                                    text: 'Delete',
                                                    fontSize: 12,
                                                    fontFamily: 'Bold',
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            );
                          }),
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
