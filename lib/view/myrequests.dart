import 'package:flutter/material.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:fyp/view/donors.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    var email = Auth().currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
      ),
      body: FutureBuilder(
        future: RequestStore().getWhere(requester: email!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var requests = snapshot.data;
            return ListView.builder(
              itemCount: requests!.length,
              itemBuilder: (context, index) {
                // tile to show  request

                if (requests[index].status == 'Completed') {
                  return completedTile(
                      request: requests[index]);
                } else {
                  return activeTile(request: requests[index], context: context);
                }
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget activeTile(
    {required BloodRequest request, required BuildContext context}) {
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
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DonorsPage(bloodGroup: request.blood),
        ));
      },
      isThreeLine: true,
      leading: CircleAvatar(
        child: Text(request.blood),
      ),
      title: Text(request.reason),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(request.location),
        Text(request.requestCode)
      ],),
      trailing: Container(
        height: 25,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red.shade100, borderRadius: BorderRadius.circular(20)),
        child: Text(
          request.status,
          style: TextStyle(color: Colors.red),
        ),
      ),
    ),
  );
}

Widget completedTile(
    {required BloodRequest request}) {
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
        child: Text(request.blood),
      ),
      title: Text(request.reason),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(request.location),
        
        Text('Donor: ${request.donor}')
      ],),
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
