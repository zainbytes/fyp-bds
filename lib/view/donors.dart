import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/helper_func.dart';
import 'package:fyp/view/mywidgets/others/notfound.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class DonorsPage extends StatefulWidget {
  final String bloodGroup;
  final LatLng location;
  const DonorsPage(
      {super.key, required this.bloodGroup, required this.location});

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
              if (snapshot.data==null) {
                return const NotFound();
              } else {
                
                var sortedMap = sortByDistance(snapshot.data!);
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    
                    
                    return donorTile(sortedMap.entries.elementAt(index));
                  },
                );
              }
            } else {
              return const RedCircularProgress();
            }
          },
        ));
  }

  Map<double, AppUser> sortByDistance(List<AppUser> users) {
    var mapWithDistance = <double, AppUser>{};

    for (var user in users) {
      var userLoc = latlonParse(user.location!);
      var distance = Geolocator.distanceBetween(widget.location.latitude,
          widget.location.longitude, userLoc.latitude, userLoc.longitude);
      var distanceInKm = (distance / 1000);
      if (mapWithDistance.containsKey(distanceInKm)) {
        distanceInKm+=0.001;
      }
      mapWithDistance[distanceInKm] = user;
      
    }
    

    var sortedBykey = mapWithDistance.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    var sortedMap = Map.fromEntries(sortedBykey);

    return sortedMap;
  }

  Widget donorTile(MapEntry<double, AppUser> d) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(10),
        ListTile(
          //isThreeLine: true,
          onTap: () => bottomSheet(d.value),
          titleTextStyle: TextStyle(fontSize: 20, color: angryFlamingo),
          title: Text(d.value.fullName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Hello, I am available'),
              Text('Approx. ${d.key.toStringAsFixed(2)} KM far',style: TextStyle(color: Colors.grey),)
            ],
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.red),
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

  Future<dynamic> bottomSheet(AppUser d) {
    var heading = TextStyle(
        color: angryFlamingo, fontWeight: FontWeight.bold, fontSize: 18);
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                //name
                Text(
                  'Name:',
                  style: heading,
                ),
                ListTile(
                  title: Text(d.fullName),
                ),

                //email
                Text('Email:', style: heading),
                ListTile(
                  title: Text(d.email),
                  trailing: IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: d.email));
                      },
                      icon: const Icon(Icons.copy)),
                ),

                //phone no
                Text('Phone No:', style: heading),
                ListTile(
                  title: Text(d.phoneNo),
                  trailing: IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: d.phoneNo));
                      },
                      icon: const Icon(Icons.copy)),
                ),
                const Gap(10)
              ],
            ),
          ),
        );
      },
    );
  }
}
