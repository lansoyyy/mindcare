import 'package:cloud_firestore/cloud_firestore.dart';

Future addNurse(fname, mname, lname, nname, suffix, bday, sex, gender, email,
    nurseId) async {
  final docUser = FirebaseFirestore.instance.collection('Nurse').doc(nurseId);

  final json = {
    'fname': fname,
    'mname': mname,
    'lname': lname,
    'nname': nname,
    'suffix': suffix,
    'bday': bday,
    'sex': sex,
    'gender': gender,
    'email': email,
    'year': bday.toString().split('-')[0],
    'month': bday.toString().split('-')[1],
    'day': bday.toString().split('-')[2],
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'type': 'Nurse',
    'id': nurseId,
    'profile': '',
  };

  await docUser.set(json);
}
