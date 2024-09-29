import 'package:flutter/material.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/helper_func.dart';
import 'package:fyp/view/mywidgets/others/notfound.dart';

class CompletedRequest extends StatelessWidget {
  const CompletedRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var email = Auth().currentUser!.email;
    return Scaffold(
      appBar:const CustomAppbar(title: 'Completed Requests'),
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
            return const RedCircularProgress();
          }
        },
      ),
    );
  }

  Widget completedTile({required BloodRequest request}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
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
          children: [
            Text('Created On: ${dateToString(request.createdOn)}'),
            Text('Completed On: ${dateToString(request.completedOn)}'), 
            Text('Donor: ${request.donor}')],
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
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}

