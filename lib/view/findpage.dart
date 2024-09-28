import 'package:flutter/material.dart';
import 'package:fyp/controller/bloodrequest_controller.dart';
import 'package:fyp/services/validation/validation.dart';
import 'package:fyp/view/donors.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/others/helper_func.dart';
import 'package:fyp/view/pick_location.dart';
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

  //terms & condition checkbox
  bool checkboxFlag = false;

  var requestCont = ControllerBloodRequest();


  //form key
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Center(
          child: Stepper(
              controlsBuilder: (context, details) {
                return Row(children: [
                  //means not the last step
                  _stepIndex < 3
                      ? TextButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.red.shade300),
                          ))
                      //when the final step
                      : TextButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                              backgroundColor: MaterialStatePropertyAll(
                                  checkboxFlag
                                      ? Colors.red
                                      : Colors.red.shade300)),
                          onPressed: checkboxFlag
                              ? () {
                                  // if checkbox set to ture run this code
                                  if (_formkey.currentState!.validate()) {
                                    requestCont.saveToDatabase();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Request submited')));

                                    //passing bloodgroup to donor page so that it can find user with same blood

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => DonorsPage(
                                        bloodGroup:
                                            requestCont.bloodController.text,
                                      ),
                                    ));
                                  }
                                }
                              : null,
                          child: const Text('Submit')),
                  TextButton(
                      onPressed: details.onStepCancel,
                      child: Text(
                        'cancel',
                        style: TextStyle(color: Colors.grey.shade800),
                      ))
                ]);
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
                    _stepIndex++;
                  });
                }
              },
              steps: [
                //reason for blood
                Step(
                    title: Text('Reason'),
                    content: DecoratedContainer(
                        child: TextFormField(
                            validator: (value) =>emptyValidation(value),
                            controller: requestCont.reasonController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.text_snippet_rounded),
                                border: InputBorder.none,
                                hintText: 'Why do you need Blood')))),
                //blood releated details
                Step(
                    title: Text('Blood details'),
                    content: Column(children: [
                      //blood selection chip
                      Container(
                          padding: const EdgeInsets.only(left: 20),
                          width: 350,
                          child: Wrap(
                              spacing: 25,
                              runSpacing: 10,
                              children: List<Widget>.generate(
                                  bloodGroup.length,
                                  (index) => ChoiceChip(
                                      label: Text(bloodGroup.elementAt(index)),
                                      selectedColor: angryFlamingo,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _value == index
                                              ? Colors.white
                                              : Colors.black),
                                      checkmarkColor: Colors.white,
                                      selected: _value == index,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _value = selected ? index : null;
                                          requestCont.bloodController.text =
                                              bloodGroup[_value!];
                                        });
                                      })).toList())),
                      const Gap(10),
                      DecoratedContainer(
                          child: TextFormField(
                              validator: (value) =>emptyValidation(value),
                              controller: requestCont.bloodDescriptionContoller,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.description_rounded),
                                  border: InputBorder.none,
                                  hintText: 'Other Blood releated detail')))
                    ])),
                //location where blood needed
                Step(
                    title: Text('Location'),
                    content: DecoratedContainer(
                        child: TextFormField(
                          onTap: () async{
                           var position= await Navigator.of(context).push(MaterialPageRoute(builder:(context) =>const LocationPicker(),));
                           requestCont.locationController.text=position??'null';
                           latlonParse(position);
                          },
                            readOnly: true,
                            validator: (value) =>emptyValidation(value),
                            controller: requestCont.locationController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_pin),
                                border: InputBorder.none,
                                hintText: 'Location')))),
                //accepting terms and submit request
                Step(
                    title: Text('Submit'),
                    content: Row(children: [
                      Checkbox(
                          activeColor: Colors.red,
                          value: checkboxFlag,
                          onChanged: (value) {
                            setState(() {
                              checkboxFlag = value!;
                            });
                          }),
                      const Gap(10),
                      const Text('Accept terms & conditions.',
                          style: TextStyle(fontStyle: FontStyle.italic))
                    ]))
              ]),
        ));
  }
}

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  const DecoratedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: angryFlamingo),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child);
  }
}
