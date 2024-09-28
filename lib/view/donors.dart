import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
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
          //getting list of Appuser
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
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget donorTile(AppUser d) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(10),
        ListTile(
          onTap: () => bottomSheet(d),
          titleTextStyle: TextStyle(fontSize: 20,color: angryFlamingo),
          title: Text(d.fullName),
          subtitle: Text('Hello, I am available'),
          trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.red),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            height: 20,
          ),
        )
      ],
    );
  }

  Future<dynamic> bottomSheet(AppUser d) {
    var heading =TextStyle(color: angryFlamingo,fontWeight: FontWeight.bold,fontSize: 18);
    return showModalBottomSheet(context: context, builder:(context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(10),
                    //name
                    Text('Name:',style: heading,),
                    ListTile(title: Text(d.fullName),),

                    //email
                    Text('Email:',style: heading),
                    ListTile(title: Text(d.email),trailing: IconButton(onPressed: ()async{
                      await Clipboard.setData(ClipboardData(text: d.email));
                    }, icon: Icon(Icons.copy)),),

                    //phone no
                    Text('Phone No:',style: heading),
                    ListTile(title: Text(d.phoneNo),trailing: IconButton(onPressed: ()async{
                      await Clipboard.setData(ClipboardData(text: d.phoneNo));
                    }, icon: Icon(Icons.copy)),),

                    //description
                    Text('Description:',style: heading),
                    ListTile(title: Text(d.bloodDescription),),
                    const Gap(10)
                
                  ],
                ),
              );
            },);
  }
}
