import 'package:flutter/material.dart';
import 'package:fyp/services/firestore/request_store.dart';
import 'package:gap/gap.dart';

class DonationCode extends StatefulWidget {
  const DonationCode({super.key});

  @override
  State<DonationCode> createState() => _DonationCodeState();
}

class _DonationCodeState extends State<DonationCode> {
  var codeController = TextEditingController();
  var showError = false;
  var errorText = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(50),

        //textfield for code
        Container(
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              controller: codeController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Code here'),
            ),
          ),
        ),
        const Gap(10),

        Visibility(
            visible: showError,
            child:  Text(
              errorText,
              style: TextStyle(color: Colors.red),
            )),

        const Gap(10),

        //ok button
        Container(
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () async {
                  var status = await RequestStore()
                      .updateStatus(requestCode: codeController.text);
                  if (status==1) {
                    Navigator.of(context).pop();
                  } else if(status==-1){
                    showError = true;
                    errorText="You can't use your own code";
                    setState(() {});
                  }
                  else{
                    showError = true;
                    errorText="Code is not correct or already used";
                    setState(() {});
                  }
                },
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(100, 40)),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                child: const Text(
                  'OK',
                ))),
        const Gap(30)
      ],
    );
  }
}
