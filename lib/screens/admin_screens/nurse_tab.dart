import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medzone/screens/admin_screens/auth/signup_screen.dart';
import 'package:medzone/screens/admin_screens/auth/signup_screen3.dart';
import 'package:medzone/utils/colors.dart';

import 'package:medzone/widgets/text_widget.dart';

class AdminNurseTab extends StatefulWidget {
  const AdminNurseTab({super.key});

  @override
  State<AdminNurseTab> createState() => _AdminNurseTabState();
}

class _AdminNurseTabState extends State<AdminNurseTab> {
  final messageController = TextEditingController();

  String filter = '';

  var firstnameController = TextEditingController();
  var middlenameController = TextEditingController();
  var lastnameController = TextEditingController();
  var nicknameController = TextEditingController();
  var suffixController = TextEditingController();
  var dateController = TextEditingController();
  String email = '';
  String password = '';

  String selectedSex = 'Male';
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AdminSignupScreen()));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Nurse',
                    fontSize: 24,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Nurse')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('Error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                      child: SizedBox(
                        child: ListView.builder(
                            itemCount: data.docs.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: ListTile(
                                  onTap: () async {
                                    setState(() {
                                      firstnameController.text =
                                          data.docs[index]['fname'];
                                      middlenameController.text =
                                          data.docs[index]['mname'];
                                      lastnameController.text =
                                          data.docs[index]['lname'];
                                      nicknameController.text =
                                          data.docs[index]['nname'];
                                      suffixController.text =
                                          data.docs[index]['suffix'];
                                      dateController.text =
                                          data.docs[index]['bday'];
                                      selectedSex = data.docs[index]['sex'];
                                      selectedGender =
                                          data.docs[index]['gender'];
                                    });

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminSignupScreen3(
                                                    to: true,
                                                    email: data.docs[index]
                                                        ['email'],
                                                    password: password,
                                                    firstnameController:
                                                        firstnameController,
                                                    middlenameController:
                                                        middlenameController,
                                                    lastnameController:
                                                        lastnameController,
                                                    nicknameController:
                                                        nicknameController,
                                                    suffixController:
                                                        suffixController,
                                                    dateController:
                                                        dateController,
                                                    selectedSex: selectedSex,
                                                    selectedGender:
                                                        selectedGender)));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                          text:
                                              '${data.docs[index]['fname']} ${data.docs[index]['mname'][0].toString().toUpperCase()}. ${data.docs[index]['lname']}',
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
                                                  .where('nurseId',
                                                      isEqualTo:
                                                          data.docs[index].id)
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  print(snapshot.error);
                                                  return const Center(
                                                      child: Text('Error'));
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 50),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                }

                                                final patientData =
                                                    snapshot.requireData;
                                                return Text(
                                                  patientData.docs.length
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily: 'QBold'),
                                                );
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Nurse')
                                          .doc(data.docs[index].id)
                                          .delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
