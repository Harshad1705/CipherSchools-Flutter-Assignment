import 'package:cipher_school/theme/colors.dart';
import 'package:cipher_school/theme/styles.dart';
import 'package:cipher_school/utils/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'auth_controller.dart';
import 'components/CustomTextField.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authPinController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            title: Obx(
              () => _authPinController.varient == Varient.login
                  ? Text('Login', style: Styles.inter_18_600)
                  : Text('Sign Up', style: Styles.inter_18_600),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Visibility(
                            visible:
                                _authPinController.varient == Varient.signUp,
                            child: CustomTextField(
                              controller: _authPinController.nameController,
                              title: "Name",
                            )),
                      ),
                      CustomTextField(
                        controller: _authPinController.emailController,
                        title: "Email",
                      ),
                      CustomTextField(
                        controller: _authPinController.passwordController,
                        title: "Password",
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => InkWell(
                              onTap: _authPinController.changeCheckBoxValue,
                              child: Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CustomColor.violet,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: _authPinController.isChecked.value
                                      ? Colors.blue
                                      : Colors.transparent,
                                ),
                                child: _authPinController.isChecked.value
                                    ? const Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By signing up, you agree to the ',
                                    style: Styles.inter_14_500.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service and Privacy Policy',
                                    style: Styles.inter_14_500.copyWith(
                                        color: CustomColor.violet,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: _authPinController.varient == Varient.signUp
                            ? _authPinController.signUpWithEmailAndPassword
                            : _authPinController.loginWithEmailAndPassword,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: CustomColor.violet),
                          child: Obx(()=>_authPinController.isLoading.value ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(
                              child: _authPinController.varient == Varient.login
                                  ? Text(
                                'Login',
                                style: Styles.inter_18_600
                                    .copyWith(color: Colors.white),
                              )
                                  : Text('Sign Up',
                                  style: Styles.inter_18_600
                                      .copyWith(color: Colors.white))),)
                        ),
                      ),
                    ),
                    Text(
                      'Or with',
                      style:
                          Styles.inter_14_700.copyWith(color: CustomColor.grey),
                    ),
                    GestureDetector(
                      onTap: _authPinController.signInWithGoogle,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        margin:const  EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: CustomColor.borderColor,
                            )),
                        child: Obx(()=>_authPinController.isLoading.value?Center(child: CircularProgressIndicator(),):Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                                  () => _authPinController.varient == Varient.signUp
                                  ? Text(
                                'Sign Up with Google',
                                style: Styles.inter_18_600,
                              )
                                  : Text(
                                'Login with Google',
                                style: Styles.inter_18_600,
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                   const  SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: _authPinController.changeVarient,
                      child: Obx(
                        () => RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: Styles.inter_16_500.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text:
                                    _authPinController.varient == Varient.signUp
                                        ? 'Login'
                                        : 'Sign Up',
                                style: Styles.inter_16_500.copyWith(
                                  color: CustomColor.violet,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () async {
                    //       await FirebaseAuth.instance.signOut();
                    //     },
                    //     child: Text("logout"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
