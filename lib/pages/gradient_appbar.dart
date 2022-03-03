import 'package:flutter/material.dart';

class GradientAppScreen extends StatefulWidget {
  const GradientAppScreen({Key? key}) : super(key: key);

  @override
  State<GradientAppScreen> createState() => _GradientAppScreenState();
}

class _GradientAppScreenState extends State<GradientAppScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: CustomScrollView(
        //physics: ClampingScrollPhysics(),
        //scrollBehavior: appScrollBehaviour(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Row(
              children: const [
                Icon(Icons.qr_code_2),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Gradient Appbar',
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0xffB983FF),
                      )
                    ],
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB983FF),
                    Color(0xff94B3FD),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return const Card(
                child: ListTile(
                  title: Text('This is title'),
                  subtitle: Text('This is subtitle'),
                  trailing: Icon(Icons.delete),
                ),
              );
            }, childCount: 10),
          )
        ],
      ),
    );
  }
}

class AppScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const PageScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
