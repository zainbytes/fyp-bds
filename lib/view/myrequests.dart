import 'package:flutter/material.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:fyp/view/completedreq.dart';
import 'package:fyp/view/donors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:gap/gap.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    var email = Auth().currentUser!.email;
    return Scaffold(
      appBar: CustomAppbar(title: 'Requests'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(10),
          completedReqBtn(context),
          Expanded(
            child: FutureBuilder(
              future: RequestStore().getWhere(requester: email!,status: 'Active'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var requests = snapshot.data;

                  

                  //show active requests
                  return ListView.builder(
                    itemCount: requests!.length,
                    itemBuilder: (context, index) {
                      return activeTile(
                          request: requests[index], context: context);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container completedReqBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.5))
          ],
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const CompletedRequest(),));
        },
        title: Text('Completed Request'),
        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.red,),
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
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        child: Text(request.blood),
      ),
      title: Text(request.reason),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(request.location), Text(request.requestCode)],
      ),
      trailing: Container(
        height: 25,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          request.status,
          style: TextStyle(color: Colors.red),
        ),
      ),
    ),
  );
}

