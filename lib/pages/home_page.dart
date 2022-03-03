import 'package:flutter/material.dart';

import '../utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool toggleValue = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Hive Database Example'),
        centerTitle: true,
        actions: const [
          ThemeButton(),
        ],
      ),
      body: Stack(
        children: [
          // Image.asset(
          //   'assets/images/background.png',
          //   colorBlendMode: BlendMode.modulate,
          //   color: Colors.white.withOpacity(0.1),
          //   alignment: Alignment.center,
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          // ),
          Center(
            child: Icon(
              Icons.history,
              color: Colors.purple.shade600.withOpacity(0.2),
              size: 100.0,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: _toggleButtonModified(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return const NewWidget();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  Widget _toggleButtonModified() {
    return GestureDetector(
      onTap: toggleButton,
      child: Container(
        height: 35.0,
        width: 164,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.purple.shade100,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment:
                  toggleValue ? Alignment.topRight : Alignment.bottomLeft,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              child: Container(
                alignment: Alignment.bottomRight,
                width: 85,
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Created',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: toggleValue
                              ? Colors.purple.shade400
                              : Colors.white),
                    ),
                    Text(
                      'Scanned',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: toggleValue
                              ? Colors.white
                              : Colors.purple.shade400),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _toggleButton() {
    return GestureDetector(
      onTap: toggleButton,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 40.0,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: toggleValue
              ? Colors.greenAccent.shade100
              : const Color.fromARGB(255, 253, 193, 187),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              top: 3.0,
              left: toggleValue ? 60.0 : 0.0,
              right: toggleValue ? 0.0 : 60.0,
              child: InkWell(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    // return RotationTransition(
                    //   child: child,
                    //   turns: animation,
                    // );
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: toggleValue
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 35.0,
                          key: UniqueKey(),
                        )
                      : Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          size: 35.0,
                          key: UniqueKey(),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('This is a title'),
      subtitle: const Text('This is a subtitile'),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {},
      ),
    );
  }
}
