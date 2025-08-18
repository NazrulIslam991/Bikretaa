import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtils {
  static Future<bool> checkUserExists(String email) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
