import 'package:data_store_example/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double kExpandedHeight = 200;

  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 1,
              pinned: true,
              expandedHeight: kExpandedHeight,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage())).then(
                      (value) => setState(() {}),
                    );
                  },
                  icon: Icon(Icons.settings, color: Colors.indigo.shade400),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: const [
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
                expandedTitleScale: 1.3,
                centerTitle: false,
                title: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.indigo.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                titlePadding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 15.0),
                background: const DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.bottomRight,
                      opacity: 0.6,
                      image: AssetImage(
                        'assets/images/undraw_Bibliophile_re_xarc.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    onTap: () {
                      // ignore: avoid_print
                      print("tapped");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.link),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'This is some title $index',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        'This is some subtitle of $index',
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.indigo.shade400,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 2,
                        )
                      ],
                    ),
                  );
                },
                childCount: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
