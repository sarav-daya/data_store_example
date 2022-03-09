import 'package:data_store_example/constants.dart';
import 'package:data_store_example/pages/hive_contacts.dart';
import 'package:data_store_example/pages/sliver_page.dart';
import 'package:data_store_example/pages/start_page.dart';
import 'package:data_store_example/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(kDatabaseName);
  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter<Relationship>(RelationshipAdapter());
  await Hive.openBox<Contact>(contactsBoxName);
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
            theme: ThemeData(fontFamily: 'Nunito', primarySwatch: Colors.blue),
            darkTheme:
                ThemeData(fontFamily: 'Nunito', brightness: Brightness.dark),
            themeMode: context.watch<SettingsProvider>().state.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            scrollBehavior: const ConstantScrollBehavior(),
            home: StartPage(),
          );
        },
      ),
    );
  }
}
