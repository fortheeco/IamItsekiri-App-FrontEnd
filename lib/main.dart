import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oneitsekiri_flutter/themes/theme.dart';
import 'package:oneitsekiri_flutter/screens/introduction/choose_auth_route.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      designSize: const Size(393, 940),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OneItsekiri',
        theme: appTheme,
        home: const ChooseAuthRoute(),
      ),
    );
  }
}
