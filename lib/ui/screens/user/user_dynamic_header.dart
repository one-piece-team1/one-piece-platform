import 'package:flutter/material.dart';
import 'package:one_piece_platform/ui/components/buttons/rounded_button.dart';
import 'package:one_piece_platform/ui/styles/size_config.dart';
import 'package:one_piece_platform/ui/text/expandable_text.dart';

import '../../constants.dart';

class UserDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  final double jobTitleWidth = 70.0;
  final double jobAndAgeFontSize = 17.0;
  final double nameFontSize = 20.0;
  final bool isMe = true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // get the Edit profile button or Follow button with [isMe]
    Widget getProfileBtn() {
      return isMe
          ? RoundedButton(
              onPressed: () {
                print('Edit profile got clicked');
              },
              title: 'Edit Profile',
              textColor: kPrimaryBlue,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: kPrimaryBlue, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
            )
          : RoundedButton(
              title: 'Follow', // TODO: following status
              color: kPrimaryBlue,
              textColor: kPrimaryWhite,
              onPressed: () {
                print('Follow got clicked');
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: kPrimaryBlue),
                borderRadius: BorderRadius.circular(10),
              ),
            );
      ;
    }

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
                              child: Center(
//                                alignment: Alignment.center,
                                child: ExpandableText(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat.",
                                ),
                              ),
                            ),
                          ),
                          getProfileBtn()
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
      ? SizeConfig.safeBlockVertical * 75.0
      : 550.0;

  @override
  double get minExtent => SizeConfig.safeBlockVertical != null
      ? SizeConfig.safeBlockVertical * 75.0
      : 550.0;
}
