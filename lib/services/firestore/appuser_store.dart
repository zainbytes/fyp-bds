import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/model/appuser.dart';

const String _collection = 'users';

class AppUserStore {
  final _firestore = FirebaseFirestore.instance;

  Future<void> writeUserToStore(AppUser user, String id) async {
    try {
      await _firestore.collection(_collection).doc(id).set(user.toJson());
    } catch (e) {
      print('error while writing user');
    }
  }

   Future<List<AppUser>> fetchUserWhere({required String bloodGroup}) async {
    var users =<AppUser>[];
    try {
      

      var snapshot = await _firestore
          .collection(_collection)
          .where('bloodGroup', isEqualTo: bloodGroup)
          .get();

          snapshot.docs.forEach((element) {
            users.add(AppUser.fromJson(element.data()));
           });

      
    } catch (e) {
      print(e);
    }

    return users;
  }

  // Future<AppUser?> readUserFromStore(String id) async {
  //   try {
  //     var doc = await _firestore.collection(_collection).doc(id).get();
  //     var user = AppUser.fromJson(doc.data()!);
  //     return user;
  //   } catch (e) {
  //     print('error while fetchin data');
  //     return null;
  //   }
  // }
}
