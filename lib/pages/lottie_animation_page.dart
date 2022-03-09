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
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animations/star1.json',
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animations/star2.json',
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animations/star3.json',
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_cnrpe4f9.json',
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_8elcqxrg.json',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
