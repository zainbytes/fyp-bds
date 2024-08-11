import 'package:flutter/material.dart';
import 'package:fyp/controller/bloodrequest_controller.dart';
import 'package:fyp/view/donors.dart';
import 'package:gap/gap.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  int? _value = 1;
  var bloodGroup = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
  //for steper
  int _stepIndex = 0;
  final int _totalSteps = 4;

  //terms checkbox
  bool checkboxFlag = false;

  var requestCont=ControllerBloodRequest();
  @override
  Widget build(BuildContext context) {
    return Stepper(
        controlsBuilder: (context, details) {
          return Row(
            children: [
              _stepIndex < 3
                  ? TextButton(
                      onPressed: details.onStepContinue, child: Text('Next'))
                  : TextButton(onPressed: checkboxFlag?() {
                    // if checkbox set to ture run this code
                   // requestCont.saveToDatabase();

                   //passing bloodgroup to donor page so that it can find user with same blood
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => DonorsPage(bloodGroup: requestCont.bloodController.text,),));

                  }:null, child:const Text('Submit')),
              TextButton(
                  onPressed: details.onStepCancel, child: Text('cancel')),
            ],
          );
        },
        connectorColor: MaterialStatePropertyAll(Colors.red),
        currentStep: _stepIndex,
        onStepCancel: () {
          if (_stepIndex > 0) {
            setState(() {
              _stepIndex--;
            });
          }
        },
        onStepContinue: () {
          if (_stepIndex < _totalSteps - 1) {
            setState(() {
              _stepIndex += 1;
            });
          }
        },
        steps: [
          //reason for blood
          Step(
              title: Text('Step1'),
              content: Container(
                width: 350,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300),
                child: TextField(
                  controller: requestCont.reasonController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Why do you need'),
                ),
              )),
              //blood releated details
          Step(
            title: Text('Step2'),
            content: Column(
              children: [
                //blood selection chip
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: 350,
                  child: Wrap(
                    spacing: 25,
                    runSpacing: 10,
                    children: List<Widget>.generate(
                        bloodGroup.length,
                        (index) => ChoiceChip(
                              label: Text(bloodGroup.elementAt(index)),
                              selected: _value == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _value = selected ? index : null;
                                  requestCont.bloodController.text=bloodGroup[_value!];
                                  
                                });
                              },
                            )).toList(),
                  ),
                ),
                const Gap(10),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade300),
                  child: TextField(
                    controller: requestCont.bloodDescriptionContoller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Other detail'),
                  ),
                ),
              ],
            ),
          ),
          //location where blood needed
          Step(
              title: Text('Step 3'),
              content: Container(
                width: 350,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300),
                child: TextField(
                  controller: requestCont.locationController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Location'),
                ),
              )),
              //accepting terms and submit request 
          Step(
              title: Text('Step 4'),
              content: Row(
                children: [
                  Checkbox(
                    value: checkboxFlag,
                    onChanged: (value) {
                      setState(() {
                        checkboxFlag = value!;
                      });
                    },
                  ),
                  Gap(10),
                  Text(
                    'Accept terms & conditions.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ))
        ]);
  }
}
