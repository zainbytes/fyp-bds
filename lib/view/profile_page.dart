import 'package:flutter/material.dart';
import 'package:fyp/controller/profile_controller.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/shared_pref/shared_helper.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/donationrecord.dart';
import 'package:gap/gap.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String avtar = 'a';

  @override
  void initState() {
    loadAvatar();
    super.initState();
  }

  loadAvatar() async{
    avtar  = await SharedHelper().getAvatar()??'a';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: 'Profile'),
        //body
        body: FutureBuilder(
            future: ProfileController().getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var currentUser = snapshot.data;
                if (currentUser == null) {
                  return const Center(
                    child: Text('error'),
                  );
                } else {
                  return SingleChildScrollView(
                      child: Column(children: [
                    const Gap(10),
                    //circle avatar with name first letter
                    avatar(),

                    //text with full name
                    fullname(currentUser),

                    //contact info
                    contactInfo(currentUser),

                    const Gap(20),

                    //blood detail
                    bloodDetail(currentUser),

                    //donation record
                    const Gap(20),
                    DecoratedContainerForTile(
                        child: ListTile(
                            //fetch record from database and show to user
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => const DonationRecord(),));
                            },
                            title: const Text('Donations record'))),
                    const Gap(20),

                  

                    const Gap(20)
                  ]));
                }
              }

              //while the data is loading show this
              else {
                return const RedCircularProgress();
              }
            }));
  }

  Widget bloodDetail(AppUser currentUser) {
    return DecoratedContainerForTile(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Blood info',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Gap(10),
      ListTile(
          
          shape: InputBorder.none,
          leading: const Icon(
            Icons.bloodtype,
            color: Colors.red,
          ),
          title: Text(currentUser.bloodGroup))
    ]));
  }

  Widget contactInfo(AppUser currentUser) {
    return DecoratedContainerForTile(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Contact info',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Gap(10),
      ListTile(
        leading: const Icon(Icons.phone),
        title: Text(currentUser.phoneNo),
      ),
      ListTile(leading: const Icon(Icons.email), title: Text(currentUser.email))
    ]));
  }

  Widget fullname(AppUser currentUser) {
    return Text(
      currentUser.fullName,
      style: const TextStyle(fontSize: 24),
    );
  }

  Widget avatar() {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        child:
            RandomAvatar(avtar, width: 150, height: 150, trBackground: true));
  }
}



class DecoratedContainerForTile extends StatelessWidget {
  final Widget child;
  const DecoratedContainerForTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
