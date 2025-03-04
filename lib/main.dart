import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/general_bindings.dart';
import 'common/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';
import 'user_admin/a_data/a_repositories/a_authentication/a_authentication_repository.dart';
import 'user_client/c_data/c_repositories/c_authentication/c_authentication_repository.dart';
import 'utils/theme/theme.dart';

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);


  Get.put(AuthenticationRepositoryAdmin());
  Get.put(AuthenticationRepositoryClient());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: KAppTheme.lightTheme,
        darkTheme: KAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialBinding: GeneralBindings(),
        getPages: [],
        home: OnBoardingScreen()

      //theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true,),

    );
  }
}
