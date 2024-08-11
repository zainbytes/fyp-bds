import 'package:flutter/material.dart';

import 'package:fyp/services/firestore/appuser_store.dart';

class DonorsPage extends StatefulWidget {
  final String bloodGroup;
  const DonorsPage({super.key, required this.bloodGroup});

  @override
  State<DonorsPage> createState() => _DonorsPageState();
}

class _DonorsPageState extends State<DonorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donors'),),
        body: FutureBuilder(
          //getting list of Appuser
      future: AppUserStore().fetchUserWhere(bloodGroup: widget.bloodGroup),
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return Center(child: Text('Nothig to preview'),);
          } else {
            return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:(context, index) {
              var d = snapshot.data![index];
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300),
              child: ListTile(
              leading: CircleAvatar(
                
                child: Icon(Icons.person_2_rounded),
              ),
              title: Text(d.fullName),
              subtitle: Text('${d.email} | ${d.phoneNo} | ${d.bloodGroup}'),
              
                        ),
            );
          },);
          }
          

          
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    ));
  }
}
