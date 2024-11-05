import 'package:flutter/material.dart';
import 'package:wishlist/ui/splash/splash_mixin.dart';

class SplashScreen extends StatefulWidget {
  static const String tag = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashMixin {
  @override
  void initState() {
    initialLoad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            "assets/images/diletta.png",
                          ))),
                ),
                const Text(
                  'DilettaTest',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Desafio técnico - Flutter',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
