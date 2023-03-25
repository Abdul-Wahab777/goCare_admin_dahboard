import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Screens/networkSensitiveUi/NetworkSensitiveUi.dart';
import 'package:thinkcreative_technologies/Screens/notifications/NotificationViewer.dart';
import 'package:thinkcreative_technologies/Screens/notifications/SendNotification.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseUploader.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart' as btab;
import 'package:thinkcreative_technologies/Widgets/DelayedFunction.dart';
import 'package:thinkcreative_technologies/Widgets/MyInkWell.dart';
import 'package:thinkcreative_technologies/Widgets/TimeFormatterMyTimeZone.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Widgets/myVerticaldivider.dart';
import 'package:thinkcreative_technologies/Widgets/noDataWidget.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';

class NotificationCentre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationCentreState();
  }
}

class _NotificationCentreState extends State<NotificationCentre>
    with TickerProviderStateMixin {
  //add with TickerProviderStateMixin at the end of  state declaration
  GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: 'nffjfjjfjjhhgg');
  GlobalKey<State> _keyLoader1 =
      new GlobalKey<State>(debugLabel: 'nffjfjjfjjhhgg1');
  GlobalKey<State> _keyLoader2 =
      new GlobalKey<State>(debugLabel: 'nffjfjjfjjhhgg2');

  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_hhh');
  TabController? tabController; //controller for tab
  bool isloading = true;
  String? errmessage;
  List usernotificationlist = [];
  List adminnotificationlist = [];
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    //set tabcontroller with lengther
    //vsync:this will show error if you do not add with TickerProviderStateMixin above

    tabController!.addListener(() {
      //listiner for tab events
      if (tabController!.indexIsChanging) {
        //if tab is changed
        int tabindex = tabController!.index;
        print("Current Tab is $tabindex");
        if (tabindex == 0) {
          loadNotificationsFromFirestore(DbPaths.adminnotifications);
        } else {
          loadNotificationsFromFirestore(DbPaths.usersnotifications);
        }
        //or you can use driectrly
        //print("Current Tab is ${tabController.index}");
      }
    });
    loadNotificationsFromFirestore(DbPaths.adminnotifications);
  }

  loadNotificationsFromFirestore(String document) async {
    setState(() {
      isloading = true;
      errmessage = null;
      if (document == DbPaths.adminnotifications) {
        adminnotificationlist = [];
      } else if (document == DbPaths.usersnotifications) {
        usernotificationlist = [];
      }
    });
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionnotifications)
        .doc(document)
        .get()
        .then((doc) async {
      List list = doc.data()!['list'] ?? [];
      list.forEach((element) {
        if (element.containsKey(Dbkeys.nOTIFICATIONxxtitle)) {
          if (document == DbPaths.adminnotifications) {
            adminnotificationlist.add(element);
            setState(() {});
          } else if (document == DbPaths.usersnotifications) {
            usernotificationlist.add(element);
            setState(() {});
          }
        }
      });
      if (document == DbPaths.usersnotifications &&
          usernotificationlist.length > 40) {
        usernotificationlist.reversed.toList();
        setState(() {});
        usernotificationlist.removeRange(15, list.length - 1);
        setState(() {});
        await FirebaseFirestore.instance
            .collection(DbPaths.collectionnotifications)
            .doc(document)
            .update({'list': usernotificationlist});
      } else if (document == DbPaths.adminnotifications &&
          adminnotificationlist.length > 20) {
        adminnotificationlist.reversed.toList();
        setState(() {});
        adminnotificationlist.removeRange(15, list.length - 1);
        setState(() {});
        await FirebaseFirestore.instance
            .collection(DbPaths.collectionnotifications)
            .doc(document)
            .update({'list': adminnotificationlist});
      }

      isloading = false;
      setState(() {});
    }).catchError((err) {
      errmessage =
          'Cannot fetch the $document. Please make sure you have installed & Opened the user app first. CAPTURED_ERROR:' +
              err.toString();
    });
  }

  @override
  void dispose() {
    tabController!.dispose(); //destroy tabcontroller to release memory
    super.dispose();
  }

  deleteNotification(var doc, String documentname) async {
    ShowLoading().open(key: _keyLoader, context: context);
    if (doc[Dbkeys.nOTIFICATIONxximageurl] != null) {
      await FirebaseUploader().deleteFile(
        context: context,
        scaffoldkey: _scaffoldKey,
        mykeyLoader: _keyLoader1,
        isDeleteUsingUrl: true,
        fileType: 'image',
        filename: doc[Dbkeys.docid] + '.png',
        url: doc[Dbkeys.nOTIFICATIONxximageurl],
        folder: doc[Dbkeys.docid],
        collection: DbStoragePaths.allnotifications,
      );
    }
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionnotifications)
        .doc(documentname)
        .update({
      Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionNOPUSH,
      Dbkeys.nOTIFICATIONxximageurl: null,
    });
    await delayedFunction(
        setstatefn: () async {
          await FirebaseApi().runDELETEtransaction(
              isshowmsg: false,
              keyloader: _keyLoader2,
              isshowloader: false,
              scaffoldkey: _scaffoldKey,
              context: context,
              refdata: FirebaseFirestore.instance
                  .collection(DbPaths.collectionnotifications)
                  .doc(documentname),
              compareKey: Dbkeys.docid,
              isusesecondfn: true,
              compareVal: doc[Dbkeys.docid],
              secondfn: () {
                if (documentname == DbPaths.adminnotifications) {
                  ShowLoading().close(key: _keyLoader, context: context);

                  int i = adminnotificationlist.indexWhere(
                      (element) => doc[Dbkeys.docid] == element[Dbkeys.docid]);
                  setState(() {
                    adminnotificationlist.removeAt(i);
                  });
                }

                if (documentname == DbPaths.usersnotifications) {
                  ShowLoading().close(key: _keyLoader, context: context);

                  int i = usernotificationlist.indexWhere(
                      (element) => doc[Dbkeys.docid] == element[Dbkeys.docid]);
                  setState(() {
                    usernotificationlist.removeAt(i);
                  });
                }
              });
        },
        durationmilliseconds: 0);
  }

  Widget recievedToAdminWidget(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        padding: EdgeInsets.all(12),
        //list of names of guides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            adminnotificationlist.length == 0
                ? noDataWidget(
                    padding: EdgeInsets.fromLTRB(30, w / 2.18, 30, 30),
                    context: context,
                    iconColor: Mycolors.orange,
                    iconData: Icons.notifications,
                    title: 'No Notifications',
                    subtitle: '')
                : ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: adminnotificationlist.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (adminnotificationlist.length > 0) {
                        var doc = adminnotificationlist[
                            adminnotificationlist.length - 1 - i];

                        return doc[Dbkeys.nOTIFICATIONxxtitle] == null
                            ? SizedBox()
                            : notificationcard(
                                doc: doc,
                                desc: doc[Dbkeys.nOTIFICATIONxxdesc],
                                isForAdmin: true,
                                title: doc[Dbkeys.nOTIFICATIONxxtitle],
                                timestamp: doc[Dbkeys.nOTIFICATIONxxlastupdate],
                                isSent: true,
                                url: doc[Dbkeys.nOTIFICATIONxximageurl]);
                      } else {
                        return Text('Error');
                      }
                    }),
          ],
        ));
  }

  Widget sentToUsersWidget(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        padding: EdgeInsets.all(12),
        //list of names of guides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            MySimpleButton(
              onpressed: AppConstants.isdemomode == true
                  ? () {
                      Utils.toast('Not Allowed in Demo App');
                    }
                  : () {
                      pageNavigator(
                          context,
                          SendNotification(
                            issendtosingleuser: false,
                            collection: DbPaths.collectionnotifications,
                            refdata: FirebaseFirestore.instance
                                .collection(DbPaths.collectionnotifications)
                                .doc(DbPaths.usersnotifications),
                            notificationid: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            optionalOnUpdateCallback: () {
                              loadNotificationsFromFirestore(
                                  DbPaths.usersnotifications);
                            },
                          ));
                    },
              height: 56,
              buttoncolor: Mycolors.green,
              icon: Icon(Icons.send_rounded, color: Mycolors.white),
              spacing: 0.3,
              buttontext: 'Send New Notification',
            ),
            SizedBox(
              height: 25,
            ),
            MtCustomfontBold(
              text: '  All Sent',
              fontsize: 16,
              textalign: TextAlign.start,
            ),
            myvhorizontaldivider(width: w, thickness: 1),
            usernotificationlist.length == 0
                ? noDataWidget(
                    context: context,
                    iconColor: Mycolors.orange,
                    iconData: Icons.notifications,
                    title: 'No Notifications',
                    subtitle: '')
                : ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: usernotificationlist.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (usernotificationlist.length > 0) {
                        var doc = usernotificationlist[
                            usernotificationlist.length - 1 - i];

                        return doc[Dbkeys.nOTIFICATIONxxtitle] == null
                            ? SizedBox()
                            : notificationcard(
                                doc: doc,
                                isForAdmin: false,
                                title: doc[Dbkeys.nOTIFICATIONxxtitle],
                                desc: doc[Dbkeys.nOTIFICATIONxxdesc],
                                timestamp: doc[Dbkeys.nOTIFICATIONxxlastupdate],
                                isSent: true,
                                url: doc[Dbkeys.nOTIFICATIONxximageurl]);
                      } else {
                        return Text('Error');
                      }
                    }),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
        child: Utils.getNTPWrappedWidget(Consumer<Observer>(
            builder: (context, observer, _child) => Scaffold(
                key: _scaffoldKey,
                backgroundColor: Mycolors.backgroundcolor,
                body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool isscrolled) {
                      return <Widget>[
                        SliverAppBar(
                          elevation: 1,
                          title: new MtPoppinsSemiBold(
                            lineheight: 1.5,
                            text: 'Notifications',
                            fontsize: 19,
                            color: Mycolors.white,
                          ),
                          backgroundColor: Mycolors.primary,
                          pinned: true,
                          floating: true,
                          forceElevated: isscrolled,

                          actions: <Widget>[
                            //button list at right side of appbar
                          ],

                          //set bottom if you want to add tabbar

                          bottom: new TabBar(
                            indicatorPadding: EdgeInsets.all(0),
                            isScrollable: true,
                            labelColor: Mycolors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelColor: Mycolors.whitedim,
                            indicator: new btab.BubbleTabIndicator(
                              indicatorHeight: 36.0,
                              indicatorColor: Mycolors.secondary,
                              tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            ),
                            indicatorColor: Mycolors.white,
                            tabs: <Tab>[
                              new Tab(text: " Recieved to Admin "),
                              new Tab(text: " Sent to Users "),
                            ],
                            controller: tabController,
                          ),
                        ),
                      ];
                    },
                    body: errmessage != null
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text('Error Occured !\n\n',
                                  textAlign: TextAlign.center),
                            ),
                          )
                        : isloading == true
                            ? circularProgress()
                            : TabBarView(

                                //set TabBarView  if you have added Tabbar at bottom of Appbar
                                controller: tabController,
                                children: <Widget>[
                                    recievedToAdminWidget(context),
                                    sentToUsersWidget(context)
                                  ]))))));
  }

  //widget to show name in card
  Widget notificationcard(
      {String? title,
      String? desc,
      Timestamp? timestamp,
      bool? isSent,
      String? url,
      var doc,
      bool isForAdmin = true}) {
    return Stack(
      children: [
        myinkwell(
          onTap: () {
            notificationViwer(
              context,
              desc,
              title,
              url,
              formatTimeDateCOMLPETEString(
                  isdateTime: false,
                  timestamptargetTime: doc[Dbkeys.nOTIFICATIONxxlastupdate]),
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
            decoration: boxDecoration(showShadow: true),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 110,
                  color: Mycolors.greylightcolor,
                  child: url == null
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '  NO IMAGE  ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Mycolors.greytext.withOpacity(0.5)),
                          ),
                        ))
                      : Image.network(
                          url,
                          height: 80,
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                ),
                SizedBox(
                  width: 12,
                ),
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
                            text: formatTimeDateCOMLPETEString(
                                isdateTime: false,
                                timestamptargetTime: timestamp),
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
                      text: title ?? 'Hello test notifcations title ',
                      textalign: TextAlign.left,
                      color: Mycolors.black,
                      maxlines: 1,
                      overflow: TextOverflow.ellipsis,
                      lineheight: 1.25,
                      fontsize: 15,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    MtCustomfontLight(
                      text: desc ?? 'Hello test notifcations description',
                      textalign: TextAlign.left,
                      color: Mycolors.grey,
                      maxlines: 1,
                      overflow: TextOverflow.ellipsis,
                      lineheight: 1.25,
                      fontsize: 13,
                    )
                  ],
                ))
              ],
            )),
          ),
        ),
        Positioned(
            bottom: 2,
            right: 2,
            child: IconButton(
              onPressed: AppConstants.isdemomode == true
                  ? () {
                      Utils.toast('Not Allowed in Demo App');
                    }
                  : () async {
                      await deleteNotification(
                          doc,
                          isForAdmin == true
                              ? DbPaths.adminnotifications
                              : DbPaths.usersnotifications);
                    },
              icon: Icon(Icons.delete_outline, color: Colors.red, size: 17),
            ))
      ],
    );
  }
}
