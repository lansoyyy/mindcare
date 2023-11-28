import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addPatient
(fname, mname, lname, nname, suffix, medsched,sex, gender, desc) async {
  final docUser = FirebaseFirestore.instance.collection('Patients').doc();

  final json = {
    'fname': fname,
      'mname': mname,
        'lname': lname,
          'nname': nname,
            'suffix': suffix,
              'bday': medsched,
                'sex': sex,
                  'gender': gender,
                    'isAssigned': false,
                    'desc': desc,
   
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'type': 'Nurse',
    'id': docUser.id,
    'profile': '',
    'nurseId': '',
  };

  await docUser.set(json);
}
