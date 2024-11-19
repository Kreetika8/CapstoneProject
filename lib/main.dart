import 'package:classico/views/ui/employerUI/creatework.dart';
import 'package:classico/views/ui/employerUI/mywork.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'constants/app_constants.dart';
import 'views/ui/onboarding/widgets/page_one.dart';
import 'views/ui/search/homepage.dart';
import 'views/ui/authent/profile.dart';
import 'views/ui/onboarding/onboarding_screen.dart';
import 'views/common/exports.dart';

import 'controllers/exports.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => ZoomNotifier()),
        ChangeNotifierProvider(create: (context) => SignUpNotifier()),
        ChangeNotifierProvider(create: (context) => JobsNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Capstone',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kLight.value),
            iconTheme: IconThemeData(color: Color(kDark.value)),
            primarySwatch: Colors.grey,
          ),
          initialRoute: '/onboarding',
          getPages: [
            GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
            GetPage(name: '/homepage', page: () => const Homepage()),
            GetPage(name: '/profile', page: () => const ProfilePage()),
            GetPage(name: '/pageone', page: () => const PageOne()),
            GetPage(name: '/creatework', page: () => const CreateWorkPage()), 
            GetPage(name: '/mywork', page: () => const MyWorkPage()), 
          ],
        );
      },
    );
  }
}
