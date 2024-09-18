import 'package:flutter/material.dart';
import 'package:fyp/controller/profile_controller.dart';
import 'package:fyp/view/mywidgets/others/notfound.dart';

class DonationRecord extends StatelessWidget {
  const DonationRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Donated TO')),
      content: Container(
        height: 250,
        width: 200,
        child: FutureBuilder(
          future: ProfileController()
              .getDonationRecord(),
          builder: (context, snapshot) {
            //when the data is completely loaded show this
            if (snapshot.connectionState ==
                ConnectionState.done) {
              var requests = snapshot.data;
    
              if (requests!.isEmpty) {
                return const NotFound();
              }
    
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${requests[index].requester}'),
                  );
                },
              );
            }
            //while the data is being loading show this
            else {
              return Center(
                  child:
                      CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}