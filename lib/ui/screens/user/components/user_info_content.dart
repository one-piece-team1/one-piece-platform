import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/models/entry_model.dart';
import 'package:one_piece_platform/ui/components/buttons/flat_icon_button.dart';
import 'package:one_piece_platform/ui/components/common/ticket.dart';
import 'package:one_piece_platform/ui/components/image/thumbnail.dart';
import 'package:one_piece_platform/ui/components/listItem/entry_item.dart';
import 'package:one_piece_platform/ui/screens/user/user_dynamic_header.dart';

import '../../../constants.dart';

class UserInfoContent extends StatelessWidget {
  UserInfoContent({
    this.showSpinner: false,

//    @required this.contents,
  });

  final bool showSpinner;

// The entire multilevel list displayed by this app.
  final List<Entry> data = <Entry>[
    Entry(
      'Company',
      <Entry>[
        Entry('Matcha Inc.'),
        Entry('Roasted green tea Inc.'),
        Entry('A2'),
      ],
    ),
    Entry(
      'Categories',
      <Entry>[
        Entry('B0'),
        Entry('B1'),
        Entry('B2'),
      ],
    ),
    Entry(
      'Port',
      <Entry>[
        Entry('C0'),
        Entry('C1'),
        Entry('C2'),
      ],
    ),
  ];
// The entire multilevel list displayed by this app.
  final List sortData = <String>["Most Recent", "Oldest First"];

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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            // A Row widget
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Free space will be equally divided and will be placed between the children.
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                // A Flexible widget that will make its child flexible
                                child: Text(
                                  "Filter",
                                  overflow: TextOverflow
                                      .ellipsis, // handles overflowing of text
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.clear), // some random icon
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ), //
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return EntryItem(data[index]);
                              },
                              itemCount: data.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            // A Row widget
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Free space will be equally divided and will be placed between the children.
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                // A Flexible widget that will make its child flexible
                                child: Text(
                                  "Sort",
                                  overflow: TextOverflow
                                      .ellipsis, // handles overflowing of text
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.clear), // some random icon
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ), //
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(sortData[index]),
                                  onTap: () {
                                    // TODO: sort the data
                                    print(sortData[index]);
                                  },
                                );
                              },
                              itemCount: sortData.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icons.swap_vert,
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
