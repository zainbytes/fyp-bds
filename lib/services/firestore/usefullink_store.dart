import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/model/useful_link.dart';

const String _collection = 'usefulLink';

class UsefulLinkStore {
  final _firestore = FirebaseFirestore.instance;

  Future<List<UsefulLink>> fetchLinks() async {
    var usefulLinks = <UsefulLink>[];
    var snap = await _firestore.collection(_collection).get();

    for (var link in snap.docs) {
      usefulLinks.add(UsefulLink.fromJson(link.data()));
    }

    return usefulLinks;
  }
}
