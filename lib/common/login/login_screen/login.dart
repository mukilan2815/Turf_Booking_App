import 'package:flutter/material.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    //final dark = KHelperFunctions.isDarkMode(context);

    return   const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: KSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// logo , title & sub-title
                KLoginHeader(),
                 SizedBox(height: KSizes.sm,),
                /// form
                KLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


