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
    var users = <AppUser>[];
    try {
      var snapshot = await _firestore
          .collection(_collection)
          .where('bloodGroup', isEqualTo: bloodGroup)
          .get();

      for (var element in snapshot.docs) {
        users.add(AppUser.fromJson(element.data()));
      }
    } catch (e) {
      print(e);
    }

    return users;
  }

  Future<AppUser?> readUserFromStore(String id) async {
    try {
      var doc = await _firestore.collection(_collection).doc(id).get();
      var user = AppUser.fromJson(doc.data()!);
      return user;
    } catch (e) {
      print('error while fetchin data');
      return null;
    }
  }

  Future<void> updateUser(String id,Map data) async{

    var user= await readUserFromStore(id);
    user!.fullName =data['name'];
    user.bloodGroup =data['blood'];
    user.phoneNo =data['phone'];
    user.bloodDescription =data['description'];

    await _firestore.collection(_collection).doc(id).update(user.toJson());
  }
}
