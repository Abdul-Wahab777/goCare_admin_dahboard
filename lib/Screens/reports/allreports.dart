import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Screens/reports/reportViewer.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Widgets/InfiniteList/InfiniteCOLLECTIONListViewWidget.dart';
import 'package:thinkcreative_technologies/Screens/networkSensitiveUi/NetworkSensitiveUi.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreCOLLECTIONDataProvider.dart';

class AllReports extends StatefulWidget {
  AllReports();
  @override
  _AllReportsState createState() => _AllReportsState();
}

class _AllReportsState extends State<AllReports> {
  TextEditingController _controller = new TextEditingController();

  Query? query;
  @override
  void initState() {
    super.initState();
    query = FirebaseFirestore.instance
        .collection('reports')
        .orderBy('time', descending: true)
        .limit(10);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: '0ss000');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Utils.getNTPWrappedWidget(Consumer<Observer>(
          builder: (context, observer, _child) => Consumer<CommonSession>(
                builder: (context, session, _child) =>
                    Consumer<FirestoreDataProviderREPORTS>(
                  builder: (context, firestoreDataProvider, _) => MyScaffold(
                      isforcehideback: true,
                      scaffoldkey: _scaffoldKey,
                      title: 'All Reports',
                      body: InfiniteCOLLECTIONListViewWidget(
                        firestoreDataProviderREPORTS: firestoreDataProvider,
                        datatype: Dbkeys.dataTypeREPORTS,
                        refdata: query,
                        list: ListView.builder(
                            padding: EdgeInsets.all(0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                firestoreDataProvider.recievedDocs.length,
                            itemBuilder: (BuildContext context, int i) {
                              var dc = firestoreDataProvider.recievedDocs[i];

                              return reportCard(
                                  context: context,
                                  doc: dc,
                                  onDeletePress: () {
                                    // ShowLoading().open(
                                    //     key: _keyLoader, context: context);

                                    try {
                                      FirebaseFirestore.instance
                                          .collection('reports')
                                          .doc(dc['time'].toString())
                                          .delete();
                                      firestoreDataProvider
                                          .deleteparticulardocinProvider(
                                              compareKey: 'time',
                                              compareVal: dc['time']);
                                      ShowLoading().close(
                                          key: _keyLoader, context: context);
                                    } catch (e) {
                                      // ShowLoading().close(
                                      //     key: _keyLoader, context: context);
                                    }
                                  });
                            }),
                      )),
                ),
              ))),
    );
  }
}

//  'title': 'New report by User',
//                                                                         'desc':
//                                                                             '${reportEditingController.text}',
//                                                                         'phone':
//                                                                             '${widget.currentUserNo}',
//                                                                         'type':
//                                                                             'Individual Chat',
//                                                                         'time':
//                                                                             time.millisecondsSinceEpoch,
//                                                                         'id': Fiberchat.getChatId(
//                                                                             currentUserNo,
//                                                                             peerNo),
//widget to show name in card
Widget reportCard(
    {required BuildContext context,
    required var doc,
    required Function onDeletePress}) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
        decoration: boxDecoration(showShadow: true),
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // isSent == false
                      //     ? SizedBox(
                      //         height: 0,
                      //         width: 0,
                      //       )
                      //     : Container(
                      //         width: 80,
                      //         height: 20,
                      //         child: Row(
                      //           crossAxisAlignment:
                      //               CrossAxisAlignment.center,
                      //           children: [
                      //             Icon(
                      //               Icons.check_circle_outline_rounded,
                      //               size: 18,
                      //               color: Mycolors.green,
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             MtCustomfontMedium(
                      //               text: 'Sent',
                      //               fontsize: 13,
                      //               color: Mycolors.green,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      MtCustomfontLight(
                        text: getWhen(doc['time']),
                        textalign: TextAlign.right,
                        color: Mycolors.greytext,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                MtCustomfontRegular(
                  text: 'Sent by:   ' + doc['phone'],
                  textalign: TextAlign.left,
                  color: Mycolors.purple,
                  maxlines: 1,
                  overflow: TextOverflow.ellipsis,
                  lineheight: 1.25,
                  fontsize: 12,
                ),
                SizedBox(
                  height: 6,
                ),
                MtCustomfontLight(
                  text: doc['desc'] ?? 'Hello test notifcations description',
                  textalign: TextAlign.left,
                  color: Mycolors.black,
                  maxlines: 2,
                  overflow: TextOverflow.ellipsis,
                  lineheight: 1.25,
                  fontsize: 14,
                ),
                SizedBox(
                  height: 7,
                ),
                MtCustomfontRegular(
                  text: 'For:   ' + doc['type'],
                  textalign: TextAlign.left,
                  color: Mycolors.grey,
                  maxlines: 1,
                  overflow: TextOverflow.ellipsis,
                  lineheight: 1.25,
                  fontsize: 12,
                ),
              ],
            ))
          ],
        )),
      ),
      Positioned(
          bottom: 2,
          right: 2,
          child: IconButton(
            onPressed: AppConstants.isdemomode == true
                ? () {
                    Utils.toast('Not Allowed in Demo App');
                  }
                : () {
                    onDeletePress();
                  },
            icon: Icon(Icons.delete_outline, color: Colors.red, size: 19),
          )),
      Positioned(
          bottom: 2,
          right: 52,
          child: IconButton(
            onPressed: () async {
              reportViewer(context, doc);
            },
            icon: Icon(Icons.visibility, color: Colors.blue, size: 19),
          ))
    ],
  );
}

getWhen(milliseconds) {
  var date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  String when;
  when = DateFormat.MMMd().format(date);
  return when;
}
