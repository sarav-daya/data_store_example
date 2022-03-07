import 'package:flutter/material.dart';

class ShowBottomPage extends StatefulWidget {
  const ShowBottomPage({Key? key}) : super(key: key);

  @override
  State<ShowBottomPage> createState() => _ShowBottomPageState();
}

class _ShowBottomPageState extends State<ShowBottomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Bottom Modal'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // showModalBottomSheet(
              //   backgroundColor: Colors.transparent,
              //   context: context,
              //   isScrollControlled: true,
              //   isDismissible: true,
              //   enableDrag: false,
              //   builder: (BuildContext context) {
              //     return DraggableScrollableSheet(
              //       initialChildSize: 0.7, //set this as you want
              //       maxChildSize: 0.7, //set this as you want
              //       minChildSize: 0.7, //set this as you want
              //       expand: true,
              //       snap: true,
              //       builder: (context, scrollController) {
              //         return Container(
              //           color: Colors.white,
              //         ); //whatever you're returning, does not have to be a Container
              //       },
              //     );
              //   },
              // );

              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: false,
              //   elevation: 1.0,
              //   builder: (context) {
              //     return Container(
              //       child: Container(),
              //     );
              //   },
              // );

              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Wrap(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            },
            child: Text('Show Modal'),
          ),
        ),
      ),
    );
  }
}
