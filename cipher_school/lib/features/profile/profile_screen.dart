import 'package:cipher_school/features/authentication/auth_screen.dart';
import 'package:cipher_school/features/profile/profle_controller.dart';
import 'package:cipher_school/theme/colors.dart';
import 'package:cipher_school/theme/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  GetStorage storage = GetStorage();
  ProfileController profileController = ProfileController();
  @override
  Widget build(BuildContext context) {
    String? name = storage.read('name');
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColor.bgWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/avatar.png',
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: Styles.inter_14_500
                            .copyWith(color: CustomColor.grey),
                      ),
                      Text(
                        name == null ? " " : profileController.capitalize(name),
                        style: Styles.inter_24_600
                            .copyWith(color: CustomColor.baseColor),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _showNameInputDialog(context);
                    },
                    child: Image.asset(
                      'assets/images/edit.png',
                      height: 32,
                      width: 32,
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: Column(children: [
                  profileWidget(title: 'Account', img: 'wallet'),
                  const Divider(
                    color: CustomColor.bgWhite,
                  ),
                  profileWidget(title: 'Settings', img: 'settings'),
                  const Divider(
                    color: CustomColor.bgWhite,
                  ),
                  profileWidget(title: 'Export Data', img: 'upload'),
                  const Divider(
                    color: CustomColor.bgWhite,
                  ),
                  GestureDetector(
                    onTap: () async {
                      profileController.signOutMethod();
                    },
                    child: Obx(
                      () => profileController.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: CircularProgressIndicator(),
                            )
                          : profileWidget(title: 'Logout', img: 'logout'),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }

  profileWidget({required String title, required String img}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 50,
            width: 50,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: title == 'Logout'
                  ? CustomColor.lightRed
                  : CustomColor.lightPurple,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/${img}.png',
              ),
            ),
          ),
          Text(
            title,
            style: Styles.inter_16_500,
          )
        ],
      ),
    );
  }

  void _showNameInputDialog(BuildContext context) {
    String name = ''; // Initial value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Name'),
          content: TextField(
            controller: profileController.nameController,
            // onChanged: (value) {
            //   name = value;
            // },
            decoration: InputDecoration(
              hintText: 'Type your name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: profileController.updateName,
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
