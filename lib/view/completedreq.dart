import 'package:flutter/material.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/notfound.dart';

class CompletedRequest extends StatelessWidget {
  const CompletedRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var email = Auth().currentUser!.email;
    return Scaffold(
      appBar: CustomAppbar(title: 'Completed Requests'),
      body: FutureBuilder(
        future: RequestStore().getWhere(requester: email!, status: 'Completed'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var requests = snapshot.data;

            if (requests!.isNotEmpty) {
              return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return completedTile(request: requests[index]);
              },
            );
            } else {
              return const NotFound();
            }

            //show active requests
            
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget completedTile({required BloodRequest request}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.5))
          ]),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          foregroundColor: Colors.white,
        backgroundColor: Colors.red,
          child: Text(request.blood),
        ),
        title: Text(request.reason),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(request.location), Text('Donor: ${request.donor}')],
        ),
        trailing: Container(
          height: 25,
          width: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            request.status,
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
