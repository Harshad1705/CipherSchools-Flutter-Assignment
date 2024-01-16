import 'package:cipher_school/features/authentication/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../theme/colors.dart';
import '../../theme/styles.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: CustomColor.purple,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 30,
              left: 20,
              child: Image.asset(
                'assets/images/logo.png',
                height: 60,
                width: 60,
              ),
            ),
            Positioned(
              bottom: 80,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Welcome to',
                            style: Styles.abeezee_40_400,
                          ),
                          Text(
                            'CipherX.',
                            style: Styles.logoText,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          GetStorage().write('splash',true);
                          Get.offAll(()=>AuthScreen());
                        },
                        child: Container(
                          height: 90,
                          padding: EdgeInsets.all(10),
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEDE1E1),
                          ),
                          child: Center(
                              child: SvgPicture.asset('assets/images/arrow.svg')),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('The best way to track your expenses.',style: Styles.abeezee_20_400,)
                ],
              ),
            ),
            // Positioned(
            //   child: Center(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           'assets/images/logo.png',
            //           color: Colors.white,
            //           height: 100,
            //           width: 100,
            //         ),
            //         // Image.asset('assets/images/logo.svg'),
            //         Text(
            //           'CipherX',
            //           style: Styles.logoText,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 20,
            //   child: Center(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'By',
            //           style: Styles.logoSecondaryText.copyWith(fontSize: 12),
            //         ),
            //         RichText(
            //           text: TextSpan(
            //             style: Styles.logoSecondaryText,
            //             children: [
            //               TextSpan(
            //                 text: 'Open Source ',
            //               ),
            //               TextSpan(
            //                 text: 'Community',
            //                 style: TextStyle(color: Colors.orange),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/topright.png',
                  height: 300,
                  width: 300,
                )),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/bottomleft.png',
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
