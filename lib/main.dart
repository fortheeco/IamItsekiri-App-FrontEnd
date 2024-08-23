import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/theme.dart';
import 'package:oneitsekiri_flutter/routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/utils/register_adapters.dart';
import 'package:oneitsekiri_flutter/utils/snack_bar.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await RegisterAdapters.registerAdapters();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final asyncValue = ref.watch(checkTokenProvider);
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
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'OneItsekiri',
        theme: appTheme,
        home: asyncValue.when(
            loading: () => Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  color: Palette.darkRedA,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Palette.whiteA,
                    ),
                  ),
                ),
            error: (error, stackTrace) => Scaffold(
                  body: Center(child: Text(error.toString())),
                ),
            data: (widget) => widget),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
