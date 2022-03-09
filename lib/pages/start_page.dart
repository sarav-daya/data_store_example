import 'package:data_store_example/pages/android_platform_code.dart';
import 'package:data_store_example/pages/gradient_appbar.dart';
import 'package:data_store_example/pages/history_page.dart';
import 'package:data_store_example/pages/hive_contacts.dart';
import 'package:data_store_example/pages/loading_page.dart';
import 'package:data_store_example/pages/rating_dialog_page.dart';
import 'package:data_store_example/pages/rating_page.dart';
import 'package:data_store_example/pages/regular_appbar.dart';
import 'package:data_store_example/pages/save_to_file.dart';
import 'package:data_store_example/pages/settings_page.dart';
import 'package:data_store_example/pages/sliver_background.dart';
import 'package:data_store_example/pages/sliver_home.dart';
import 'package:data_store_example/pages/stack_positioned.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'fluttring_rating_bar_page.dart';
import 'home_page.dart';
import 'show_model_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Examples'),
        actions: const [
          ThemeButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: ListView(
            children: [
              ListItem(
                title: 'Gradient Appbar',
                widget: GradientAppScreen(),
              ),
              ListItem(
                title: 'History Page',
                widget: HistoryPage(),
              ),
              ListItem(
                title: 'Home Page',
                widget: HomePage(),
              ),
              ListItem(
                title: 'Loading Page',
                widget: LoadingPage(
                  title: 'Loading Page',
                ),
              ),
              ListItem(
                title: 'Sliver background',
                widget: SliverBackgroundPage(),
              ),
              ListItem(
                title: 'Stacked Positioned',
                widget: StackPositionedPage(),
              ),
              ListItem(
                title: 'Sliver Page',
                widget: SliverHomePage(),
              ),
              ListItem(
                title: 'Show Modal Page',
                widget: ShowBottomPage(),
              ),
              ListItem(
                title: 'Settings Page',
                widget: SettingsPage(),
              ),
              ListItem(
                title: 'SaveFile Page',
                widget: SaveToFilePage(),
              ),
              ListItem(
                title: 'Regular Appbar Page',
                widget: RegularAppbarScreen(),
              ),
              ListItem(
                title: 'AndroidPlatform Code Page',
                widget: AndroidPlatformPage(),
              ),
              ListItem(
                title: 'Rating Page',
                widget: RatingPage(),
              ),
              ListItem(
                title: 'Rating Dialog Page',
                widget: RatingDialogPage(),
              ),
              ListItem(
                title: 'Flutting Rating Bar Page',
                widget: FlutterRatingBarPage(),
              ),
              ListItem(
                title: 'Hive Database Page',
                widget: HiveContactsPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Widget widget;
  final String title;
  const ListItem({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget)),
        child: Text(title),
      ),
    );
  }
}
