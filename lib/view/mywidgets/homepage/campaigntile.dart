import 'package:flutter/material.dart';

class CampaignTile extends StatelessWidget {
  const CampaignTile({
    super.key
  });

  

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return ListTile(
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
      contentPadding: EdgeInsets.symmetric(
          horizontal: screenHeight * .03, vertical: screenHeight * .02),
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
      tileColor: Colors.grey.shade200,
      title: const Text('Campaign title'),
      subtitle: const Text(
          'Description of campaign sdhjshd askdhaskdhmamsa ad kjdhdkahdma adhkawdmabiu cuhkabsbad'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}