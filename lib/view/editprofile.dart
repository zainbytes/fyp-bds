import 'package:flutter/material.dart';
import 'package:fyp/controller/profile_controller.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/shared_pref/shared_helper.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/others/bottomsheet_blood.dart';
import 'package:fyp/view/mywidgets/others/circular_indicator.dart';
import 'package:fyp/view/mywidgets/others/pickavatar.dart';
import 'package:gap/gap.dart';
import 'package:random_avatar/random_avatar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String avatar = 'a';

  @override
  void initState() {
    loadAvatar();
    super.initState();
  }

  loadAvatar() async {
    avatar = await SharedHelper().getAvatar() ?? 'a';
  }

  @override
  Widget build(BuildContext context) {
    var profileController = ProfileController();
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit profile',
        centerTitle: false,
        actions: [
          saveButton(
            onPressed: () async {
              await profileController.updateProfile();
              await SharedHelper().setAvatar(avatar);

              if (context.mounted) {
                Navigator.of(context).pop('sucess');
              }
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: profileController.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var user = snapshot.data;
            if (user != null) {
              setInitialValues(profileController, user);
            }

            return Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                const Gap(20),
                StatefulBuilder(
                  builder: (context, update) {
                    return GestureDetector(
                        onTap: () async {
                          var result = await showDialog(
                            context: context,
                            builder: (context) {
                              return const PickAvatar();
                            },
                          );

                          update(() {
                            avatar = result;
                          });
                        },
                        child: RandomAvatar(avatar, width: 150));
                  },
                ),
                const Gap(40),
                EditTextfield(
                  textController: profileController.nameEditor,
                  label: "Name",
                ),
                const Gap(20),
                EditTextfield(
                  textController: profileController.phoneEditor,
                  label: "Phone no",
                ),
                const Gap(20),
                EditTextfield(
                  readOnly: true,
                  ontap: () async {
                    var result = await showModalBottomSheet(
                        context: context,
                        builder: (context) => const BottomSheetForBlood());
                    profileController.bloodEditor.text = result ?? 'B+';
                  },
                  textController: profileController.bloodEditor,
                  label: "Blod Group",
                ),
                const Gap(20),
                EditTextfield(
                  textController: profileController.descriptionEditor,
                  label: "Description",
                ),
              ],
            );
          } else {
            return const RedCircularProgress();
          }
        },
      ),
    );
  }

  void setInitialValues(ProfileController profileController, AppUser user) {
    profileController.nameEditor.text = user.fullName;
    profileController.phoneEditor.text = user.phoneNo;
    profileController.bloodEditor.text = user.bloodGroup;
    profileController.descriptionEditor.text = user.bloodDescription;
  }

  Padding saveButton({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: TextButton(
          style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              foregroundColor:const MaterialStatePropertyAll(Colors.red),
              backgroundColor: MaterialStatePropertyAll(Colors.red.shade100)),
          onPressed: onPressed,
          child: const Text('Save')),
    );
  }
}

class EditTextfield extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final VoidCallback? ontap;
  final bool? readOnly;
  const EditTextfield({
    required this.label,
    required this.textController,
    this.ontap,
    this.readOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: TextField(
          readOnly: readOnly ?? false,
          onTap: ontap,
          controller: textController,
          decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: Colors.red),
              labelText: label,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.red))),
        ));
  }
}
