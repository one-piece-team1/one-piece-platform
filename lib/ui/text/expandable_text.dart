import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  _setIsExpanded() {
    setState(() {
      isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: new Column(children: <Widget>[
        new ConstrainedBox(
          constraints: isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(maxHeight: 30.0),
          child: new Text(
            widget.text,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        isExpanded
            ? new Container()
            : new FlatButton(
                child: const Text('...'),
                onPressed: () {
                  _setIsExpanded();
                })
      ]),
    );
  }
}
