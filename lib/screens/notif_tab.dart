import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/widgets/text_widget.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Notifications',
                      fontSize: 24,
                      fontFamily: 'Bold',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.warning,
                      ),
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                 StreamBuilder<QuerySnapshot>(
                                stream:   FirebaseFirestore.instance
                                    .collection('Patients')
                                    .where('nurseId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                    return SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.notifications),
                              title: TextWidget(
                                  text: data.docs[index]['desc'], fontSize: 14),
                              subtitle: TextWidget(text: data.docs[index]['fname'] + ' ' + data.docs[index]['lname'], fontSize: 12),
                              trailing:
                                  TextWidget(text: data.docs[index]['bday'], fontSize: 10),
                            ),
                          );
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
