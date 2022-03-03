import 'package:data_store_example/pages/settings_page.dart';
// import 'package:data_store_example/providers/settings.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class SliverBackgroundPage extends StatefulWidget {
  const SliverBackgroundPage({Key? key}) : super(key: key);

  @override
  State<SliverBackgroundPage> createState() => _SliverBackgroundPageState();
}

class _SliverBackgroundPageState extends State<SliverBackgroundPage> {
  final double kExpandedHeight = 200;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //_scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateQR(
          scrollController: _scrollController,
          kExpandedHeight: kExpandedHeight,
          opacity: _opacity),
    );
  }

  double get _opacity {
    if (_scrollController.hasClients) {
      // ignore: avoid_print
      if (_scrollController.offset < (kExpandedHeight - kToolbarHeight) / 3) {
        return _scrollController.offset /
            (kExpandedHeight - kToolbarHeight) /
            3;
      } else {
        final val =
            _scrollController.offset / (kExpandedHeight - kToolbarHeight);
        return val <= 1 ? val : 1;
      }
    }
    return 0;
  }

  // double get _horizontalTitlePadding {
  //   const kBasePadding = 25.0;
  //   const kMultiplier = 0.5;

  //   if (_scrollController.hasClients) {
  //     if (_scrollController.offset < (kExpandedHeight / 2)) {
  //       // In case 50%-100% of the expanded height is viewed
  //       return kBasePadding;
  //     }

  //     if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
  //       // In case 0% of the expanded height is viewed
  //       return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
  //           kBasePadding;
  //     }

  //     // In case 0%-50% of the expanded height is viewed
  //     final finalPadding =
  //         (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
  //             kBasePadding;

  //     return finalPadding;
  //   }
  //   return kBasePadding;
  // }
}

class CreateQR extends StatefulWidget {
  const CreateQR({
    Key? key,
    required ScrollController scrollController,
    required this.kExpandedHeight,
    required double opacity,
  })  : _scrollController = scrollController,
        _opacity = opacity,
        super(key: key);

  final ScrollController _scrollController;
  final double kExpandedHeight;
  final double _opacity;

  @override
  State<CreateQR> createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('widget rebuild...');
    return CustomScrollView(
      controller: widget._scrollController,
      slivers: [
        SliverAppBar(
          elevation: 1,
          pinned: true,
          expandedHeight: widget.kExpandedHeight,
          backgroundColor: Colors.white,
          title: Opacity(
            opacity: widget._opacity,
          ),
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
              'Let\'s Make QR',
              style: TextStyle(
                fontSize: 18,
                color: Colors.indigo.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
            titlePadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
            background: const DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  opacity: 0.6,
                  image: AssetImage(
                    'assets/images/undraw_Add_files_re_v09g.png',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'This is some title $index',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                  Text(
                                    'This is some subtitle of $index',
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.grey.shade800,
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
    );
  }
}
