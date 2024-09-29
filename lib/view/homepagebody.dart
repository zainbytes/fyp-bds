import 'package:flutter/material.dart';
import 'package:fyp/model/useful_link.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:fyp/services/firestore/usefullink_store.dart';
import 'package:fyp/view/donation_code.dart';
import 'package:fyp/view/healthtips.dart';
import 'package:fyp/view/myrequests.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/profile_page.dart';
import 'package:fyp/view/useful_link_page.dart';
import 'package:gap/gap.dart';


class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    
    // var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //request generated info counter
          const RequestCounter(),

          const Gap(10),

          //button row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SpecialButton(
                  label: "Health tips",
                  icon: Icons.tips_and_updates,
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HealthTipsPage(),
                    ));
                  }),
              const Gap(5),
              SpecialButton(
                  label: 'Profile',
                  icon: Icons.account_circle,
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
                  }),
            ],
          ),
          const Gap(5),

          //button row 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SpecialButton(
                  label: "My Requests",
                  icon: Icons.history_edu,
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyRequests(),
                    ));
                  }),
              const Gap(5),
              SpecialButton(
                  label: "Donation Code",
                  icon: Icons.receipt,
                  ontap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const DonationCode();
                        });
                  }),
            ],
          ),
          const Gap(10),
          //title what new
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Text(
              "Useful links",
              style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const Gap(10),
          //campaign tile
          Expanded(
            child: FutureBuilder(
              future: UsefulLinkStore().fetchLinks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var links = snapshot.data;
                  return ListView.builder(
                      itemCount: links!.length,
                      itemBuilder: (context, index) =>
                          usefulLinkTile(ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewLink(link: links[index])));
                          }, links[index]));
                } else {
                  
                  return const RedCircularProgress();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget usefulLinkTile(UsefulLink link, {VoidCallback? ontap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image:  DecorationImage(
            image: NetworkImage(link.imageLink??''), fit: BoxFit.cover),
      ),
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), 
            gradient: LinearGradient(
                colors: [Colors.black.withOpacity(.75), Colors.transparent])),
        child: ListTile(
          onTap: ontap,
          subtitleTextStyle:const TextStyle(color: Colors.white),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey.shade100),
          title: Text(link.title ?? ''),
          subtitle: Text(link.organization ?? ''),
        ),
      ),
    );
  }
}

//special button widget
class SpecialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback ontap;
  //final Widget? avatar;

  const SpecialButton({
    required this.label,
    required this.icon,
    required this.ontap,
    // this.avatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: GestureDetector(
        onTap: () => ontap(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * .015),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.red,
              ),
              Text(
                label,
                style: TextStyle(
                    color: Colors.red.shade400, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestCounter extends StatelessWidget {
  const RequestCounter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return  FutureBuilder(
      future: RequestStore().getCount() ,
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.done) {
         var count =snapshot.data;
          return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                count!['Total'].toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('Request generated')
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(count['Completed'].toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('Completed')
            ],
          )
        ],
      );
        } else {
          return const RedCircularProgress();
        }
        
      },
    );
  }
}
