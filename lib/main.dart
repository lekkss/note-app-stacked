import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/firebase_options.dart';
import 'package:note_app/locator.dart';
import 'package:note_app/routes.dart';
import 'package:note_app/services/navigation_services.dart';
import 'package:note_app/ui/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await setupLocator();
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
    debugPrint("Failed to setup Locator");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: BotToastInit(),
      // builder: (context, child) => Navigator(
      //   key: locator<DialogService>().dialogNavigationKey,
      //   onGenerateRoute: (settings) => MaterialPageRoute(
      //     builder: (context) => DialogManager(
      //       child: child,
      //     ),
      //   ),
      // ),
      navigatorKey: locator<MyNavigationServices>().naigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      routes: appRoutes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const SplashScreen(),
        );
      },
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
    );
  }
}
