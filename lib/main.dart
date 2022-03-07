// import 'package:data_store_example/pages/gradient_appbar.dart';
// import 'package:data_store_example/pages/regular_appbar.dart';
// import 'package:data_store_example/pages/sliver_background.dart';
// import 'package:data_store_example/pages/stack_positioned.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:data_store_example/pages/sliver_home.dart';
// import 'package:data_store_example/pages/show_model_page.dart';
// import 'package:data_store_example/pages/save_to_file.dart';
import 'package:data_store_example/constants.dart';
import 'package:data_store_example/pages/loading_page.dart';
import 'package:data_store_example/pages/sliver_page.dart';
import 'package:data_store_example/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(kDatabaseName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(
            isDarkMode: Hive.box(kDatabaseName).get('darkMode') ?? false,
          ),
        )
      ],
      child: Builder(
        builder: (context) {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
          );
          return MaterialApp(
            title: 'Flutter Test Apps',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Nunito').copyWith(),
            darkTheme:
                ThemeData(fontFamily: 'Nunito', brightness: Brightness.dark),
            themeMode: context.watch<SettingsProvider>().state.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            scrollBehavior: const ConstantScrollBehavior(),
            home: LoadingPage(
              title: 'Loading Page',
            ),
          );
        },
      ),
    );
  }
}
