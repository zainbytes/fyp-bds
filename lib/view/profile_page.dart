import 'package:flutter/material.dart';
import 'package:fyp/controller/profile_controller.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: FutureBuilder(
            future: ProfileController().getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var currentUser = snapshot.data!;
                return SingleChildScrollView(
                    child: Column(children: [
                  //circle avatar with name first letter
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 75,
                        child: Text(
                          currentUser.fullName[0],
                          style: TextStyle(fontSize: 64),
                        ),
                      )),

                  //text with full name
                  Text(
                    currentUser.fullName,
                    style: TextStyle(fontSize: 28),
                  ),

                  //contact info
                  DecoratedContainerForTile(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Contact info',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Gap(10),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(currentUser.phoneNo),
                        ),
                        ListTile(
                            leading: Icon(Icons.email),
                            title: Text(currentUser.email))
                      ])),

                  Gap(20),

                  //blood detail
                  DecoratedContainerForTile(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Blood info',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Gap(10),
                        ExpansionTile(
                            expandedAlignment: Alignment.centerLeft,
                            shape: InputBorder.none,
                            leading: Icon(
                              Icons.bloodtype,
                              color: Colors.red,
                            ),
                            title: Text(currentUser.bloodGroup),
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(currentUser.bloodDescription))
                            ])
                      ])),

                  //donation record
                  Gap(20),
                  DecoratedContainerForTile(
                      child: ListTile(
                          //fetch record from database and show to user
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
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
                                            return Center(
                                                child: Text(
                                                    ('You did not donated yet')));
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
                              },
                            );
                          },
                          title: const Text('Donations record'))),
                  const Gap(20)
                ]));
              }

              //while the data is loading show this
              else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
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
