import 'package:data_store_example/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.read<SettingsProvider>().toggleDarkMode,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: context.watch<SettingsProvider>().darkMode
            ? Icon(
                Icons.brightness_4_outlined,
                key: UniqueKey(),
              )
            : Icon(
                Icons.brightness_2_outlined,
                key: UniqueKey(),
              ),
      ),
    );
  }
}
