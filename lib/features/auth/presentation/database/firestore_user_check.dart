import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
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

  // Fetch user data by UID
  static Future<UserModel?> getUserInformationByUid(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
