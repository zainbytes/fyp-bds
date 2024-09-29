import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:fyp/view/completedreq.dart';
import 'package:fyp/view/donors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/helper_func.dart';
import 'package:fyp/view/view_map.dart';
import 'package:gap/gap.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    var email = Auth().currentUser!.email;
    return Scaffold(
      appBar: const CustomAppbar(title: 'Requests'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          completedReqBtn(context),
          const Gap(20),
          Expanded(
            child: FutureBuilder(
              future:
                  RequestStore().getWhere(requester: email!, status: 'Active'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var requests = snapshot.data;

                  //show active requests
                  return ListView.builder(
                    itemCount: requests!.length,
                    itemBuilder: (context, index) {
                      return activeTile(
                          request: requests[index], context: context);
                    },
                  );
                } else {
                  return const RedCircularProgress();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container completedReqBtn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.5))
          ],
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CompletedRequest(),
          ));
        },
        title: const Text('Completed Request'),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget activeTile(
      {required BloodRequest request, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.5))
          ]),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        leading: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          child: Text(request.blood),
        ),
        title: Text(request.reason),
        subtitle: Text(dateToString(request.createdOn)),
        trailing: Container(
          height: 25,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            request.status,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Request info'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Created On: ${dateToString(request.createdOn)}'),
                              const Gap(5),
                              Text('Description: ${request.bloodDescription}'),
                              const Gap(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Location:'),
                                  GestureDetector(
                                      onTap: () {
                                        var loc = latlonParse(request.location);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ViewMap(location: loc),
                                        ));
                                      },
                                      child: const Text(
                                        ' View on map',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  const Icon(Icons.map)
                                ],
                              ),
                              const Gap(5),
                              Text('Request code: ${request.requestCode}')
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [Icon(Icons.info), Text('Info')],
                  )),
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: request.requestCode));
                  },
                  icon: const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [Icon(Icons.copy), Text('Copy code')],
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DonorsPage(bloodGroup: request.blood),
                    ));
                  },
                  icon: const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [Icon(Icons.search), Text('Donors')],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
