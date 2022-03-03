import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _settings;

  @override
  void initState() {
    _settings = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.grey.shade800),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 14,
              separatorBuilder: (context, index) => const Divider(height: 2.0),
              itemBuilder: ((context, index) {
                return SwitchListTile(
                  activeColor: Colors.indigo.shade400,
                  title: const Text('Show animator'),
                  subtitle:
                      const Text('Animated line scrolling in the scan area'),
                  value: _settings,
                  onChanged: (value) => setState(() {
                    _settings = value;
                  }),
                );
              }),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.share,
                      color: Colors.indigo.shade500,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    const Text('Share with friends'),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink.shade500,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    const Text('Rate Us'),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.indigo.shade500,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    const Text('Send us feedbak..'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
