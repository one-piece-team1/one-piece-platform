import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../constants.dart';

class Ticket extends StatelessWidget {
  static const String id = 'ticket';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[300],
                blurRadius: 2.0,
              ),
            ],
          ),
          constraints: const BoxConstraints(minWidth: 158, maxHeight: 190),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xFF8EA6E5),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                    ),
                  ),
                  child: new ListTile(
                    trailing: Text(
                      'D7890',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Wrap(
                      spacing: 12, // space between two widgets
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Ahoy Ahoy!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Chip(
                          backgroundColor: Color(0xFFCA4D4D),
                          label: Text(
                            'Ocean',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TicketContent(
                        from: 'Depart',
                        destination: 'Keelung Port',
                        date: '2020/12/25 Fri',
                        time: '16:21',
                      ),
                      SizedBox(
                        height: 109,
                        child: Container(
                          color: Colors.grey[600],
                          width: 1.5,
                        ),
                      ),
                      TicketContent(
                        from: 'Arrived',
                        destination: 'Taipei Port',
                        date: '2020/12/29 Tue',
                        time: '13:41',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TicketContent extends StatelessWidget {
  TicketContent({
    this.from,
    this.destination,
    this.date,
    this.time,
  });

  final String from;
  final String destination;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            from,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: kBoxHeight,
          ),
          Text(
            ' ' + destination,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: kBoxHeight,
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: kBoxHeight,
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
