import 'package:flutter/material.dart';
import 'package:fyp/view/donation_code.dart';
import 'package:fyp/view/healthtips.dart';
import 'package:fyp/view/myrequests.dart';
import 'package:fyp/view/mywidgets/homepage/campaigntile.dart';
import 'package:fyp/view/profile_page.dart';
import 'package:gap/gap.dart';
import 'package:random_avatar/random_avatar.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
   // var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
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
                    icon:  Icons.account_circle,
                    
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
            Gap(10),
            //title what new
            Container(
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                "What's new",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            Gap(10),
            //campaign tile
            Column(
              children: List.generate(
                  10,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CampaignTile(),
                      )),
            )
          ],
        ),
      ),
    );
  }
}

//special button widget
class SpecialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback  ontap;
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
        onTap: () => ontap() ,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * .015),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            
              color: Colors.red.shade50, borderRadius: BorderRadius.circular(15)),
          child: Column(
            
            children: [
              
              Icon(icon,color: Colors.red,),
              
              Text(label,style: TextStyle(color: Colors.red.shade400,fontWeight: FontWeight.w500),),
              
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '3467',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Request generated')
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('2336',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Completed')
          ],
        )
      ],
    );
  }
}
