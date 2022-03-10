import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationPage extends StatefulWidget {
  const LottieAnimationPage({Key? key}) : super(key: key);

  @override
  State<LottieAnimationPage> createState() => _LottieAnimationPageState();
}

class _LottieAnimationPageState extends State<LottieAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lottie Animations')),
      body: Center(
        child: ListView(
          children: [
            Container(
              color: Colors.red.shade100,
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/animations/star1.json',
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/animations/star2.json',
              ),
            ),
            Container(
              color: Colors.red.shade100,
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/animations/star3.json',
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              height: 100,
              width: 100,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_cnrpe4f9.json',
              ),
            ),
            Container(
              color: Colors.red.shade100,
              height: 100,
              width: 100,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_8elcqxrg.json',
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/animations/scan.json',
              ),
            ),
            Container(
              color: Colors.red.shade100,
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/animations/scan1.json',
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/animations/scan2.json',
              ),
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.red.shade100,
              child: Lottie.asset('assets/animations/scan3.json',
                  fit: BoxFit.contain),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Lottie.asset(
                'assets/animations/scan4.json',
              ),
            ),
            Container(
              height: 100,
              width: 100,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_tazts8oq.json',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
