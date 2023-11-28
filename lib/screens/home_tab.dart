import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/screens/doctor_profile_screen.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/text_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final searchController = TextEditingController();
  String nameSearched = '';

  List<String> selectedStatus = [
    'All',
    'General',
    'Nutritionist',
    'Dentist',
    'Neurologist',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Hello Nurse!',
                        fontSize: 18,
                        fontFamily: 'Bold',
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: 'November 22, 2023',
                fontSize: 18,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 20,
              ),
            StreamBuilder<QuerySnapshot>(
                                stream:   FirebaseFirestore.instance
                                    .collection('Patients')
                                    // .where('nurseId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                   .orderBy('dateTime', descending: true)
                                  
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 10, left: 10),
                            child: Container(
                              height: 150,
                              width: 125,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.account_box_sharp, size: 85),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        text: data.docs[index]['fname'] + ' ' + data.docs[index]['lname'],
                                        fontSize: 14,
                                        fontFamily: 'Bold',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        text: data.docs[index]['desc'],
                                        fontSize: 12,
                                        fontFamily: 'Regular',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        text: '${data.docs[index]['bday']}',
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
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
