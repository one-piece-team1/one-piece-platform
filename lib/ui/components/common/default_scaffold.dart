import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/ui/styles/size_config.dart';
import 'package:one_piece_platform/ui/text/expandable_text.dart';

import '../../constants.dart';

class DefaultScaffold extends StatelessWidget {
  DefaultScaffold({
    this.showSpinner: false,

//    @required this.contents,
  });

  final bool showSpinner;

//  final List<Widget> contents;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt,
                  color: const Color(0xFF414141),
                ),
                label: Text(
                  "Filter",
                  style: TextStyle(
                    color: const Color(0xFF414141),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.grey[600],
                width: 2,
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.sort,
                  color: const Color(0xFF414141),
                ),
                label: Text(
                  "Sort",
                  style: TextStyle(
                    color: const Color(0xFF414141),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              floating: true,
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
                  BodyWidget(Colors.grey),
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
  final double jobTitleWidth = 70.0;
  final double jobAndAgeFontSize = 17.0;
  final double nameFontSize = 20.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final Color color = Colors.primaries[index];
      final double percentage =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);
      MediaQueryData queryData;
      queryData = MediaQuery.of(context);
      if (++index > Colors.primaries.length - 1) index = 0;
      SizeConfig().init(context);

      return Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
          gradient: LinearGradient(colors: [Colors.indigo[900], Colors.indigo]),
        ),
        height: SizeConfig.safeBlockVertical * 400.0,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    //clip half of avatar edge
                    top: circleRadius / 2.0),
                child: Container(
                  //replace this Container with your Card description
                  color: Colors.white,
                  height: SizeConfig.safeBlockVertical * 400.0,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 5.0,
                          ),
                          Text(
                            'Evena',
                            style: TextStyle(
                              fontSize: nameFontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: jobTitleWidth,
                                              child: Text(
                                                'Captain',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: jobAndAgeFontSize,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockVertical * 2.0,
                                      child: Container(
                                        color: Colors.grey[900],
                                        width: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: jobTitleWidth,
                                              child: Text(
                                                '18',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: jobAndAgeFontSize,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Followers',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.safeBlockVertical *
                                                    2.0,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '120',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockVertical * 10.0,
                                      child: Container(
                                        color: Colors.grey[900],
                                        width: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Followings',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.safeBlockVertical *
                                                    2.0,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '152',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: queryData.size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: ExpandableText(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: circleRadius,
                height: circleRadius,
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
  double get maxExtent => SizeConfig.safeBlockVertical != null
      ? SizeConfig.safeBlockVertical * 70.0
      : 500.0;

  @override
  double get minExtent => SizeConfig.safeBlockVertical != null
      ? SizeConfig.safeBlockVertical * 70.0
      : 500.0;
}
