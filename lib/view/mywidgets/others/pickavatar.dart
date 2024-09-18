import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:random_avatar/random_avatar.dart';

class PickAvatar extends StatefulWidget {
  const PickAvatar({super.key});

  @override
  State<PickAvatar> createState() => _PickAvatarState();
}

class _PickAvatarState extends State<PickAvatar> {
  String avatar ='a';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [TextButton(
        style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.red)),
        onPressed: (){
          Navigator.of(context).pop(avatar);
        }, child: const Text('Save'))],
      title: const Text('Pick avatar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          RandomAvatar(avatar.isNotEmpty?avatar:'a', width: 150),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  
                  avatar=value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Type anything',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ],
      ),
    );
  }
}
