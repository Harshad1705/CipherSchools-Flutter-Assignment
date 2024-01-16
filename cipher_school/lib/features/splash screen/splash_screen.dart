import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/colors.dart';
import '../../theme/styles.dart';
import 'next_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NextScreen()),
      );
    });
  }
    @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        color: Colors.white,
                        height: 100,
                        width: 100,
                      ),
                      // Image.asset('assets/images/logo.svg'),
                      Text(
                        'CipherX',
                        style: Styles.logoText,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By',
                        style: Styles.logoSecondaryText.copyWith(fontSize: 12),
                      ),
                      RichText(
                        text: TextSpan(
                          style: Styles.logoSecondaryText,
                          children: [
                            TextSpan(
                              text: 'Open Source ',
                            ),
                            TextSpan(
                              text: 'Community',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
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
      ),
    );
  }
}
