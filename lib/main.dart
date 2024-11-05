import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/core/configs.dart';
import 'package:wishlist/managers/app_manager.dart';
import 'package:wishlist/managers/products_manager.dart';
import 'package:wishlist/managers/wishlist_manager.dart';
import 'package:wishlist/routes/app_routes.dart';
import 'package:wishlist/ui/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Configs().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsManager(),
        ),
      ],
      child: MaterialApp(
        title: 'Diletta WishList',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.tag,
        onGenerateRoute: AppRoutes.generateRoutes,
        theme: ThemeData(
          fontFamily: GoogleFonts.sourceSansPro().fontFamily,
        ),
      ),
    );
  }
}
