import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/notfound.dart';
import 'package:gap/gap.dart';

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
        appBar: CustomAppbar(title: "Donors for ${widget.bloodGroup}"),
        body: FutureBuilder(
          //getting list of donors
          future: AppUserStore().fetchUserWhere(bloodGroup: widget.bloodGroup),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.isEmpty) {
                return const NotFound();
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var d = snapshot.data![index];
                    return donorTile(d);
                  },
                );
              }
            } else {
              return const RedCircularProgress();
            }
          },
        ));
  }

  Widget donorTile(AppUser d) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(10),
        ListTile(
          onTap: () => bottomSheet(d),
          titleTextStyle: TextStyle(fontSize: 20,color: angryFlamingo),
          title: Text(d.fullName),
          subtitle: const Text('Hello, I am available'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.red),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Divider(
            height: 20,
          ),
        )
      ],
    );
  }

  Future<dynamic> bottomSheet(AppUser d ) {
    var heading =TextStyle(color: angryFlamingo,fontWeight: FontWeight.bold,fontSize: 18);
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder:(context) {
              return Container(
                padding:  EdgeInsets.only(left: 20,right: 20,top: 20,bottom:MediaQuery.of(context).viewInsets.bottom ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      //name
                      Text('Name:',style: heading,),
                      ListTile(title: Text(d.fullName),),
                  
                      //email
                      Text('Email:',style: heading),
                      ListTile(title: Text(d.email),trailing: IconButton(onPressed: ()async{
                        await Clipboard.setData(ClipboardData(text: d.email));
                      }, icon: const Icon(Icons.copy)),),
                  
                      //phone no
                      Text('Phone No:',style: heading),
                      ListTile(title: Text(d.phoneNo),trailing: IconButton(onPressed: ()async{
                        await Clipboard.setData(ClipboardData(text: d.phoneNo));
                      }, icon: const Icon(Icons.copy)),),
                  
                      //description
                      Text('Description:',style: heading),
                      ListTile(title: Text(d.bloodDescription),),
                      const Gap(10)
                  
                    ],
                  ),
                ),
              );
            },);
  }
}
