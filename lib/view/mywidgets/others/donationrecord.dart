import 'package:flutter/material.dart';
import 'package:fyp/controller/profile_controller.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/helper_func.dart';
import 'package:fyp/view/mywidgets/others/notfound.dart';
import 'package:fyp/view/view_map.dart';
import 'package:gap/gap.dart';

class DonationRecord extends StatelessWidget {
  const DonationRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Donation history'),
      body: FutureBuilder(
        future: ProfileController().getDonationRecord(),
        builder: (context, snapshot) {
          //when the data is completely loaded show this
          if (snapshot.connectionState == ConnectionState.done) {
            var requests = snapshot.data;

            if (requests!.isEmpty) {
              return const NotFound();
            }

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return showDonationTile(context, requests[index],index);
              },
            );
          }
          //while the data is being loading show this
          else {
            return const RedCircularProgress();
          }
        },
      ),
    );
  }

  Widget showDonationTile(BuildContext context, BloodRequest request,int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20)),
            child: Text('Donation # ${index+1}',style: const TextStyle(color: Colors.white),)),
          const Gap(10),
          info('Requester', request.requester),
          const Gap(5),
          info('Blood Group', request.blood),
          const Gap(5),
          info('Description', request.bloodDescription),
          const Gap(5),
          info('Created On', dateToString(request.createdOn)),
          const Gap(5),
          info('Completed On', dateToString(request.completedOn)),
          const Gap(5),
          info('Location', 'View on map',color: Colors.blue,ontap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewMap(location: latlonParse(request.location)),
                  ));
          },),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>
          //               ViewMap(location: latlonParse(request.location)),
          //         ));
          //   },
          //   child: Text(
          //     'View on map',
          //     style: TextStyle(color: Colors.blue),
          //   ),
          // )
        ],
      ),
    );
  }

  Row info(String title, String info,{VoidCallback? ontap,Color? color}) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Text(title,style: const TextStyle(color: Colors.red),),
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: ontap,
          child: Text(info,style: TextStyle(color: color),)),
        const Gap(20),
      ],
    );
  }
}
