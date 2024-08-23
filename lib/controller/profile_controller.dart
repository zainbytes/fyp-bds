import 'package:fyp/model/appuser.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
import 'package:fyp/services/firestore/request_store.dart';

class ProfileController {
  Future<AppUser> getCurrentUser() async {
    var id = Auth().currentUser!.uid;

    var user = await AppUserStore().readUserFromStore(id);

    return user!;
  }

  Future<List<BloodRequest>> getDonationRecord() async {
    var email = Auth().currentUser!.email;

    var request = await RequestStore().getWhereDonor(donor: email!);

    return request;
  }
}
