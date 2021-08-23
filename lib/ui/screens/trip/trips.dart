import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/ui/components/buttons/rounded_button_icon.dart';
import 'package:one_piece_platform/ui/components/common/ticket.dart';
import 'package:one_piece_platform/ui/components/image/thumbnail.dart';
import 'package:one_piece_platform/ui/styles/custom_text_style.dart';

import '../../constants.dart' as k;

class Trips extends StatelessWidget {
  Trips({
    this.showSpinner: false,
  });
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Ahoy!'), // You can add title here
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            // TODO: pop is not working with navigation bar
            onPressed: () => Navigator.of(context).pop(),
          ),
          // TODO: the top right icon
          backgroundColor: Colors.indigo[900], //You can make this transparent
          elevation: 0.0, //No shadow
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        '最近行程',
                        style: CustomTextStyle.headline3(context),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Ticket(),
                      SizedBox(
                        height: 14.0,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 100.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        print('index');
                        print(index);
                        if (index == 5
                            // index == buildingData.buildingCount
                            ) {
                          return RoundedButtonIcon(
                              onPressed: () {},
                              icon: Icons.arrow_forward_ios,
                              color: k.kPrimaryBlue,
                              shape: CircleBorder(),
                              iconColor:k.kPrimaryWhite,
                            iconSize:32.0,
                            constraints: BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                          );
                        }
                        return Container(
                          width: 100.0,
                          child: Card(
                            child: Thumbnail('https://picsum.photos/100'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
