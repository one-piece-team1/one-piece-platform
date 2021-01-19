import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DefaultScaffold extends StatelessWidget {
  DefaultScaffold({
    this.showSpinner: false,
//    @required this.contents,
  });

  final bool showSpinner;
//  final List<Widget> contents;
//TODO: how to pass multiple widgets just like react slot
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.indigo[900],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''), // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          // TODO: pop is not working with navigation bar
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900], //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: false,
              delegate: MyDynamicHeader(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget("Header 1"),
                  HeaderWidget("Header 2"),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BodyWidget(Colors.blue),
                  BodyWidget(Colors.red),
                  BodyWidget(Colors.green),
                  BodyWidget(Colors.orange),
                  BodyWidget(Colors.blue),
                  BodyWidget(Colors.red),
                ],
              ),
            ),
            SliverGrid(
              delegate: SliverChildListDelegate([
                BodyWidget(Colors.blue),
                BodyWidget(Colors.red),
                BodyWidget(Colors.green),
                BodyWidget(Colors.orange),
                BodyWidget(Colors.blue),
                BodyWidget(Colors.red),
                BodyWidget(Colors.red),
                BodyWidget(Colors.green),
                BodyWidget(Colors.orange),
                BodyWidget(Colors.blue),
                BodyWidget(Colors.red),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
//    return Scaffold(
//      backgroundColor: Colors.white,
//      extendBodyBehindAppBar: true,
//      body: ModalProgressHUD(
//        inAsyncCall: showSpinner,
//        child: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: Stack(
//            children: <Widget>[
//              Container(
//                height: screenSize.height * 0.2,
//                color: Colors.grey[600],
//              ),
//              Padding(
//                padding: EdgeInsets.symmetric(
//                  horizontal: screenSize.height * 0.06,
//                ),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    SizedBox(
//                      height: screenSize.height * 0.15,
//                    ),
//                    ClipRRect(
//                      borderRadius: BorderRadius.circular(20),
//                      child: Container(
//                        height: screenSize.height * 0.1,
//                        child: Image.asset('images/logo.png'),
//                      ),
//                    ),
//                    CustomScrollView(
//                      slivers: <Widget>[
//                        SliverList(
//                          delegate: SliverChildListDelegate(
//                            [
//                              HeaderWidget("Header 1"),
//                              HeaderWidget("Header 2"),
//                              HeaderWidget("Header 3"),
//                              HeaderWidget("Header 4"),
//                            ],
//                          ),
//                        ),
//                        SliverList(
//                          delegate: SliverChildListDelegate(
//                            [
//                              BodyWidget(Colors.blue),
//                              BodyWidget(Colors.red),
//                              BodyWidget(Colors.green),
//                              BodyWidget(Colors.orange),
//                              BodyWidget(Colors.blue),
//                              BodyWidget(Colors.red),
//                            ],
//                          ),
//                        ),
//                        SliverGrid(
//                          delegate: SliverChildListDelegate([
//                            BodyWidget(Colors.blue),
//                            BodyWidget(Colors.red),
//                            BodyWidget(Colors.green),
//                            BodyWidget(Colors.orange),
//                            BodyWidget(Colors.blue),
//                            BodyWidget(Colors.red),
//                            BodyWidget(Colors.red),
//                            BodyWidget(Colors.green),
//                            BodyWidget(Colors.orange),
//                            BodyWidget(Colors.blue),
//                            BodyWidget(Colors.red),
//                          ]),
//                          gridDelegate:
//                              SliverGridDelegateWithFixedCrossAxisCount(
//                            crossAxisCount: 4,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//              new Positioned(
//                top: 0.0,
//                left: 0.0,
//                right: 0.0,
//                child: AppBar(
//                  title: Text(''), // You can add title here
//                  leading: new IconButton(
//                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
//                    onPressed: () => Navigator.of(context).pop(),
//                  ),
//                  backgroundColor:
//                      Colors.grey[800], //You can make this transparent
//                  elevation: 0.0, //No shadow
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(text),
      color: Colors.grey[200],
    );
  }
}

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,
    );
  }
}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final Color color = Colors.primaries[index];
      final double percentage =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

      if (++index > Colors.primaries.length - 1) index = 0;

      return Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
          gradient: LinearGradient(colors: [Colors.indigo[900], Colors.indigo]),
        ),
        height: constraints.maxHeight,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: circleRadius / 2.0),
                child: Container(
                  //replace this Container with your Card
                  color: Colors.white,
                  height: 200,
                ),
              ),
              Container(
                width: circleRadius,
                height: circleRadius,
//                decoration:
//                    ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(circleBorderWidth),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/a/a0/Bill_Gates_2018.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;
}