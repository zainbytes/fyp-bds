import 'package:flutter/material.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:gap/gap.dart';

class BottomSheetForBlood extends StatefulWidget {
  const BottomSheetForBlood({super.key});

  @override
  State<BottomSheetForBlood> createState() => _BottomSheetForBloodState();
}

class _BottomSheetForBloodState extends State<BottomSheetForBlood> {
  int _value = 1;
  var bloodGroup = [
                    'A+',
                    'B+',
                    'AB+',
                    'O+',
                    'A-',
                    'B-',
                    'AB-',
                    'O-'
                  ];
  @override
  Widget build(BuildContext context) {
    return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Choose blood type',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                              spacing: 25,
                              runSpacing: 10,
                              children: List<Widget>.generate(
                                  bloodGroup.length,
                                  (index) => ChoiceChip(
                                      label:
                                          Text(bloodGroup.elementAt(index)),
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
                                          _value=index;
                                          
                                        });
                                        Navigator.of(context).pop(bloodGroup[_value]);
                                      })).toList())),
                    ],
                  );;
  }
}