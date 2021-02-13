import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/ui/components/buttons/flat_icon_button.dart';
import 'package:one_piece_platform/ui/components/common/ticket.dart';
import 'package:one_piece_platform/ui/components/image/thumbnail.dart';
import 'package:one_piece_platform/ui/screens/user/user_dynamic_header.dart';

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
              child: FlatIconButton(
                onPressed: () {},
                icon: Icons.filter_alt,
                labelText: 'Filter',
                iconColor: kIconPrimaryColor,
                textColor: kIconPrimaryColor,
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
              child: FlatIconButton(
                onPressed: () {},
                icon: Icons.sort,
                labelText: 'Sort',
                iconColor: kIconPrimaryColor,
                textColor: kIconPrimaryColor,
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
              delegate: UserDynamicHeader(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Ticket(),
                  ),
                ],
              ),
            ),
            SliverGrid(
              delegate: SliverChildListDelegate([
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
                Thumbnail('https://picsum.photos/100'),
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
