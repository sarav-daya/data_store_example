import 'package:data_store_example/pages/android_platform_code.dart';
import 'package:data_store_example/pages/compass_page.dart';
import 'package:data_store_example/pages/gradient_appbar.dart';
import 'package:data_store_example/pages/history_page.dart';
import 'package:data_store_example/pages/hive_contacts.dart';
import 'package:data_store_example/pages/loading_page.dart';
import 'package:data_store_example/pages/pdf_generator.dart';
import 'package:data_store_example/pages/rating_dialog_page.dart';
import 'package:data_store_example/pages/rating_page.dart';
import 'package:data_store_example/pages/regular_appbar.dart';
import 'package:data_store_example/pages/save_to_file.dart';
import 'package:data_store_example/pages/settings_page.dart';
import 'package:data_store_example/pages/sliver_background.dart';
import 'package:data_store_example/pages/sliver_home.dart';
import 'package:data_store_example/pages/stack_positioned.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils.dart';
import 'detail_folder_page.dart';
import 'fluttring_rating_bar_page.dart';
import 'home_page.dart';
import 'lottie_animation_page.dart';
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
        automaticallyImplyLeading: false,
        leading: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            print('object');
          },
          child: Lottie.asset(
            'assets/animations/star3.json',
          ),
        ),
        actions: const [
          ThemeButton(),
        ],
      ),
      body: Center(
        child: ListView(
          reverse: true,
          children: [
            ExampleItemTile(
              title: 'Gradient Appbar',
              widget: GradientAppScreen(),
            ),
            ExampleItemTile(
              title: 'History Page',
              widget: HistoryPage(),
            ),
            ExampleItemTile(
              title: 'Home Page',
              widget: HomePage(),
            ),
            ExampleItemTile(
              title: 'Loading Page',
              widget: LoadingPage(
                title: 'Loading Page',
              ),
            ),
            ExampleItemTile(
              title: 'Sliver background',
              widget: SliverBackgroundPage(),
            ),
            ExampleItemTile(
              title: 'Stacked Positioned',
              widget: StackPositionedPage(),
            ),
            ExampleItemTile(
              title: 'Sliver Page',
              widget: SliverHomePage(),
            ),
            ExampleItemTile(
              title: 'Show Modal Page',
              widget: ShowBottomPage(),
            ),
            ExampleItemTile(
              title: 'Settings Page',
              widget: SettingsPage(),
            ),
            ExampleItemTile(
              title: 'SaveFile Page',
              widget: SaveToFilePage(),
            ),
            ExampleItemTile(
              title: 'Regular Appbar Page',
              widget: RegularAppbarScreen(),
            ),
            ExampleItemTile(
              title: 'AndroidPlatform Code Page',
              widget: AndroidPlatformPage(),
            ),
            ExampleItemTile(
              title: 'Rating Page',
              widget: RatingPage(),
            ),
            ExampleItemTile(
              title: 'Rating Dialog Page',
              widget: RatingDialogPage(),
            ),
            ExampleItemTile(
              title: 'Flutting Rating Bar Page',
              widget: FlutterRatingBarPage(),
            ),
            ExampleItemTile(
              title: 'Hive Database Page',
              widget: HiveContactsPage(),
            ),
            ExampleItemTile(
              title: 'Lottie Animation Page',
              widget: LottieAnimationPage(),
            ),
            ExampleItemTile(
              title: 'Compass Application',
              widget: FlutterCompassPage(),
            ),
            ExampleItemTile(
              title: 'Flutter PDF Generator',
              widget: PDFGeneratorPage(),
            ),
            ExampleItemTile(
              title: 'Details Folder Page',
              widget: DetailsFolderPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleItemTile extends StatelessWidget {
  final Widget widget;
  final String title;
  const ExampleItemTile({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.phone_android_outlined),
          trailing: Icon(Icons.arrow_forward_sharp),
          onTap: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => widget));
          }),
          title: Text(title),
        ),
        Divider(
          height: 2,
        )
      ],
    );
  }
}
