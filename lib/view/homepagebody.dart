import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/view/healthtips.dart';
import 'package:fyp/view/mywidgets/homepage/campaigntile.dart';
import 'package:gap/gap.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //request generated info counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '3467',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Request generated')
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('2336',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Completed')
                  ],
                )
              ],
            ),

            const Gap(10),

            //button row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => const HealthTipsPage(),));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * .015),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(children: [
                        Icon(Icons.tips_and_updates_rounded),
                        Text('Health tips'),
                    
                      ],),
                    ),
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * .015),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(children: [
                      Icon(Icons.person),
                      Text('Profile'),

                    ],),
                  ),
                ),
              ],
            ),
            const Gap(5),

            //button row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * .015),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(children: [
                      Icon(Icons.history),
                      Text('History'),

                    ],),
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * .015),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(children: [
                      Icon(Icons.receipt),
                      Text('Donation code'),

                    ],),
                  ),
                ),
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


