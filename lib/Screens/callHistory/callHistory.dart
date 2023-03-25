import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreCOLLECTIONDataProvider.dart';
import 'package:thinkcreative_technologies/Widgets/InfiniteList/InfiniteCOLLECTIONListViewWidget.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';

class CallHistory extends StatefulWidget {
  final String? userphone;
  final String? fullname;
  CallHistory({required this.userphone, required this.fullname});
  @override
  _CallHistoryState createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  SharedPreferences? prefs;

  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(widget.fullname);
    print(widget.userphone);
    return Consumer<FirestoreDataProviderCALLHISTORY>(
      builder: (context, firestoreDataProvider, _) => MyScaffold(
        title: 'Call History',
        subtitle: widget.fullname,
        scaffoldkey: _scaffold,
        body: InfiniteCOLLECTIONListViewWidget(
          firestoreDataProviderCALLHISTORY: firestoreDataProvider,
          datatype: Dbkeys.dataTypeCALLHISTORY,
          refdata: FirebaseFirestore.instance
              .collection(DbPaths.collectionusers)
              .doc(widget.userphone)
              .collection(DbPaths.collectioncallhistory)
              .orderBy('TIME', descending: true)
              .limit(14),
          list: ListView.builder(
              padding: EdgeInsets.only(bottom: 150),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: firestoreDataProvider.recievedDocs.length,
              itemBuilder: (BuildContext context, int i) {
                var dc = firestoreDataProvider.recievedDocs[i];
                return Container(
                  decoration: boxDecoration(
                    showShadow: true,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                        height: 40,
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection(DbPaths.collectionusers)
                                .doc(dc['PEER'])
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var user = snapshot.data.data();
                                return SizedBox(
                                  height: 40,
                                  child: ListTile(
                                    isThreeLine: false,
                                    leading: Stack(
                                      children: [
                                        customCircleAvatar(
                                            url: user['photoUrl']),
                                        dc['STARTED'] == null ||
                                                dc['ENDED'] == null
                                            ? SizedBox(
                                                height: 0,
                                                width: 0,
                                              )
                                            : Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      6, 2, 6, 2),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green[400],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Text(
                                                    dc['ENDED']
                                                                .toDate()
                                                                .difference(dc[
                                                                        'STARTED']
                                                                    .toDate())
                                                                .inMinutes <
                                                            1
                                                        ? dc['ENDED']
                                                                .toDate()
                                                                .difference(dc[
                                                                        'STARTED']
                                                                    .toDate())
                                                                .inSeconds
                                                                .toString() +
                                                            's'
                                                        : dc['ENDED']
                                                                .toDate()
                                                                .difference(dc[
                                                                        'STARTED']
                                                                    .toDate())
                                                                .inMinutes
                                                                .toString() +
                                                            'm',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ))
                                      ],
                                    ),
                                    title: Text(
                                      user['nickname'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            dc['TYPE'] == 'INCOMING'
                                                ? (dc['STARTED'] == null
                                                    ? Icons.call_missed
                                                    : Icons.call_received)
                                                : (dc['STARTED'] == null
                                                    ? Icons.call_made_rounded
                                                    : Icons.call_made_rounded),
                                            size: 15,
                                            color: dc['TYPE'] == 'INCOMING'
                                                ? (dc['STARTED'] == null
                                                    ? Colors.redAccent
                                                    : Colors.green[400])
                                                : (dc['STARTED'] == null
                                                    ? Colors.redAccent
                                                    : Colors.green[400]),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(Jiffy(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          dc["TIME"]))
                                                  .MMMMd
                                                  .toString() +
                                              ', ' +
                                              Jiffy(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          dc["TIME"]))
                                                  .Hm
                                                  .toString()),
                                          // Text(time)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return Container();
                              }
                            }),
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

Widget customCircleAvatar({String? url, double? radius}) {
  if (url == null || url == '') {
    return CircleAvatar(
      backgroundColor: Color(0xffE6E6E6),
      radius: radius ?? 30,
      child: Icon(
        Icons.person,
        color: Color(0xffCCCCCC),
      ),
    );
  } else {
    return CircleAvatar(
      backgroundColor: Color(0xffE6E6E6),
      radius: radius ?? 30,
      backgroundImage: NetworkImage('$url'),
    );
  }
}
