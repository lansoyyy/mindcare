import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medzone/screens/auth/signup_screen2.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';

class AdminPatientsTab extends StatefulWidget {
  const AdminPatientsTab({super.key});

  @override
  State<AdminPatientsTab> createState() => _AdminPatientsTabState();
}

class _AdminPatientsTabState extends State<AdminPatientsTab> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: show,
          child: FloatingActionButton(
            backgroundColor: primary,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignupScreen2()));
              
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Patients',
                      fontSize: 24,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const TabBar(
                  tabs: [
                    Tab(
                      text: 'Not Assigned',
                    ),
                    Tab(
                      text: 'Assigned',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    children: [
                      for (int i = 0; i < 2; i++)
                        StreamBuilder<QuerySnapshot>(
                                stream:  i == 0 ?  FirebaseFirestore.instance
                                    .collection('Patients')
                                    .where('isAssigned', isEqualTo: false)
                                  
                                    .snapshots() :  FirebaseFirestore.instance
                                    .collection('Patients')
                                    .where('isAssigned', isEqualTo: true)
                                  
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
                            return ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: SizedBox(
                                    height: 150,
                                    width: 400,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.account_box,
                                        size: 75,),
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
                                              text: '${data.docs[index]['fname']} ${data.docs[index]['mname'][0].toString().toUpperCase()}. ${data.docs[index]['lname']}',
                                              fontSize: 14,
                                              fontFamily: 'Bold',
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextWidget(
                                              text: '"${data.docs[index]['desc']}',
                                              fontSize: 12,
                                              fontFamily: 'Regular',
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextWidget(
                                              text: data.docs[index]['bday'],
                                              fontSize: 12,
                                              fontFamily: 'Medium',
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextWidget(
                                              text: data.docs[index]['time'],
                                              fontSize: 12,
                                              fontFamily: 'Medium',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            i == 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ButtonWidget(
                                                        radius: 100,
                                                        width: 75,
                                                        height: 30,
                                                        fontSize: 12,
                                                        label: 'Assign',
                                                        onPressed: () async {

                                                          setState(() {
                                                            show = false;
                                                          });
                                                         


                                                          showBottomSheet(context: context, builder: (context) {
                                                            return Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Align(
                                                                  alignment: Alignment.topRight,
                                                                  child: IconButton(onPressed: () {
                                                                     setState(() {
                                                            show = true;
                                                          });
                                                                    Navigator.pop(context);
                                                                  }, icon: Icon(Icons.close)),
                                                                ),
                                                                SizedBox(
                                                                  height: 300,
                                                                  child: StreamBuilder<QuerySnapshot>(
                                                                                                stream: FirebaseFirestore.instance
                                                                                                    .collection('Nurse')
                                                                                                  
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
                                                                
                                                                                                  final nursedata = snapshot.requireData;
                                                                                  return SizedBox(
                                                                                    height: 500,
                                                                                    child: ListView.builder(
                                                                                        itemCount: data.docs.length,
                                                                                        itemBuilder: ((context, index) {
                                                                                          return Padding(
                                                                                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                                            child: ListTile(
                                                                                              onTap: () async {
                                                                                                // await FirebaseFirestore.instance
                                                                                                //     .collection('Messages')
                                                                                                //     .doc(data.docs[index].id)
                                                                                                //     .update({'seen': true});
                                                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                                                //     builder: (context) => ChatPage(
                                                                                                //           userId: data.docs[index]['userId'],
                                                                                                //           userName: data.docs[index]
                                                                                                //                   ['userName'] ??
                                                                                                //               'User name',
                                                                                                //         )));
                                                                                              },
                                                                                              leading: const CircleAvatar(
                                                                                                maxRadius: 25,
                                                                                                minRadius: 25,
                                                                                                backgroundImage: NetworkImage(''),
                                                                                                child: Icon(
                                                                                                  Icons.person,
                                                                                                  color: Colors.black,
                                                                                                  size: 35,
                                                                                                ),
                                                                                              ),
                                                                                              subtitle: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  TextWidget(
                                                                                                      text: '${nursedata.docs[index]['fname']} ${nursedata.docs[index]['mname'][0].toString().toUpperCase()}. ${nursedata.docs[index]['lname']}',
                                                                                                      fontSize: 15,
                                                                                                      fontFamily: 'Bold',
                                                                                                      color: Colors.black),
                                                                                                   Row(
                                                                                                    mainAxisAlignment:
                                                                                                        MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                    StreamBuilder<QuerySnapshot>(
                                                                                              stream: FirebaseFirestore.instance
                                                                                                  .collection('Patients')
                                                                                                  .where('nurseId', isEqualTo: nursedata.docs[index].id)
                                                                                                
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
                                                                
                                                                                                final patientData = snapshot.requireData;
                                                                                                          return Text(
                                                                                                            patientData.docs.length.toString(),
                                                                                                            maxLines: 1,
                                                                                                            overflow: TextOverflow.ellipsis,
                                                                                                            style: TextStyle(
                                                                                                                fontWeight: FontWeight.w800,
                                                                                                                fontSize: 12,
                                                                                                                color: Colors.black,
                                                                                                                fontFamily: 'QBold'),
                                                                                                          );
                                                                                                        }
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              trailing: TextButton(onPressed: () async {
                                                                                                 await FirebaseFirestore.instance.collection('Patients').doc(data.docs[index].id).update({
                                                            'isAssigned': true,
                                                            'nurseId': nursedata.docs[index].id
                                                          });

                                                          Navigator.pop(context);
                                                                
                                                                                              }, child: TextWidget(text: 'Assign', fontSize: 18,),),
                                                                                            ),
                                                                                          );
                                                                                        })),
                                                                                  );
                                                                                }
                                                                              ),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      ButtonWidget(
                                                        color: Colors.red,
                                                        radius: 100,
                                                        width: 75,
                                                        height: 30,
                                                        fontSize: 12,
                                                        label: 'Delete',
                                                        onPressed: ()  async{
                                                           await FirebaseFirestore.instance.collection('Patients').doc(data.docs[index].id).delete()
;                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
