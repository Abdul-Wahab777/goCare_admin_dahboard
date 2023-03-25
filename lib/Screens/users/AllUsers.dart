import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Screens/users/SearchByName.dart';
import 'package:thinkcreative_technologies/Screens/users/SearchUser.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Widgets/InfiniteList/InfiniteCOLLECTIONListViewWidget.dart';
import 'package:thinkcreative_technologies/Screens/networkSensitiveUi/NetworkSensitiveUi.dart';
import 'package:thinkcreative_technologies/Widgets/MyInkWell.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Widgets/CustomCard.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreCOLLECTIONDataProvider.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';

class AllUsers extends StatefulWidget {
  final String? pagecollectiontype;
  final String? pagekeyword;
  final Query preloadedQuery;
  AllUsers(
      {this.pagecollectiontype,
      this.pagekeyword,
      required this.preloadedQuery});
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers>with SingleTickerProviderStateMixin<AllUsers> {
  TextEditingController _controller = new TextEditingController();
TabController? tabController;
  Query? query;
  List<String>tab=[];
  @override
  void initState() {
    super.initState();
    query = widget.preloadedQuery;
    tabController=TabController(length: 5, vsync: this);
    tab=
    [
      "DOCTORS",
      "PATIENTS"
    ];
  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  confirmchangeswitch(
    BuildContext context,
    String accountSTATUS,
    String? userid,
    String? fullname,
    String? photourl,
  ) async {
    final session = Provider.of<CommonSession>(context, listen: false);
    final firestore =
        Provider.of<FirestoreDataProviderUSERS>(context, listen: false);
    final observer = Provider.of<Observer>(context, listen: false);
    ShowSnackbar().close(context: context, scaffoldKey: _scaffoldKey);
    await ShowConfirmWithInputTextDialog()
        .open(
            controller: _controller,
            isshowform: accountSTATUS == Dbkeys.sTATUSpending
                ? false
                : accountSTATUS == Dbkeys.sTATUSblocked
                    ? false
                    : accountSTATUS == Dbkeys.sTATUSallowed
                        ? true
                        : false,
            context: context,
            subtitle: accountSTATUS == Dbkeys.sTATUSallowed
                ? 'Are you sure you want to block this ${widget.pagekeyword} to use the app.'
                : accountSTATUS == Dbkeys.sTATUSblocked
                    ? 'Are you sure you want to remove the block & allow this ${widget.pagekeyword} to use the app.'
                    : 'Are you sure you want to approve & allow this ${widget.pagekeyword} to use the app.',
            title: accountSTATUS == Dbkeys.sTATUSallowed
                ? 'Block ${widget.pagekeyword} ?'
                : accountSTATUS == Dbkeys.sTATUSblocked
                    ? 'Allow ${widget.pagekeyword} ?'
                    : 'Approve ${widget.pagekeyword} ?',
            rightbtnonpress: () async {
              Navigator.pop(context);
              ShowLoading().open(context: context, key: _keyLoader);
              await FirebaseFirestore.instance
                  .collection(widget.pagecollectiontype!)
                  .doc(userid)
                  .update({
                Dbkeys.uSERactionmessage: accountSTATUS == Dbkeys.sTATUSallowed
                    ? _controller.text.trim().length < 1
                        ? 'Your account is Blocked. Reason not mentioned.'
                        : 'Your account is Blocked for the Reason: ${_controller.text.trim()}.'
                    : accountSTATUS == Dbkeys.sTATUSpending
                        ? 'Congratulations! Your account is Approved. you can now start using the app.'
                        : accountSTATUS == Dbkeys.sTATUSblocked
                            ? 'Congratulations! Block from your account is removed. You can now start using the app'
                            : 'Your account status is changed',
                Dbkeys.uSERaccountstatus: accountSTATUS == Dbkeys.sTATUSallowed
                    ? Dbkeys.sTATUSblocked
                    : accountSTATUS == Dbkeys.sTATUSblocked
                        ? Dbkeys.sTATUSallowed
                        : Dbkeys.sTATUSallowed
                // Dbkeys.cpnfilter: '$currency${!usrisvisble}',
              }).then((val) {
                // ShowLoading().close(context: context, key: _keyLoader);
              }).then((val) async {
                await FirebaseApi()
                    .runUPDATEtransactionInDocument(
                  context: context,
                  scaffoldkey: _scaffoldKey,
                  // keyloader: _keyLoader2,
                  isshowloader: false,
                  isincremental: true,
                  refdata: FirebaseFirestore.instance
                      .collection(DbPaths.collectiondashboard)
                      .doc(DbPaths.docuserscount),
                  isshowmsg: false,
                  isusesecondfn: false,
                  incrementalkey: widget.pagecollectiontype ==
                          DbPaths.collectionusers
                      ? (accountSTATUS == Dbkeys.sTATUSallowed
                          ? Dbkeys.totalblockedusers
                          : accountSTATUS == Dbkeys.sTATUSblocked
                              ? Dbkeys.totalapprovedusers
                              : Dbkeys.totalapprovedusers)
                      : widget.pagecollectiontype == DbPaths.collectionstaffs
                          ? (accountSTATUS == Dbkeys.sTATUSallowed
                              ? Dbkeys.totalblockedstaffs
                              : accountSTATUS == Dbkeys.sTATUSblocked
                                  ? Dbkeys.totalapprovedstaffs
                                  : Dbkeys.totalapprovedstaffs)
                          : widget.pagecollectiontype ==
                                  DbPaths.collectionpartners
                              ? (accountSTATUS == Dbkeys.sTATUSallowed
                                  ? Dbkeys.totalblockedpartners
                                  : accountSTATUS == Dbkeys.sTATUSblocked
                                      ? Dbkeys.totalapprovedpartners
                                      : Dbkeys.totalapprovedpartners)
                              : null,
                  decrementalkey: widget.pagecollectiontype ==
                          DbPaths.collectionusers
                      ? (accountSTATUS == Dbkeys.sTATUSallowed
                          ? Dbkeys.totalapprovedusers
                          : accountSTATUS == Dbkeys.sTATUSblocked
                              ? Dbkeys.totalblockedusers
                              : Dbkeys.totalpendingusers)
                      : widget.pagecollectiontype == DbPaths.collectionstaffs
                          ? (accountSTATUS == Dbkeys.sTATUSallowed
                              ? Dbkeys.totalapprovedstaffs
                              : accountSTATUS == Dbkeys.sTATUSblocked
                                  ? Dbkeys.totalblockedstaffs
                                  : Dbkeys.totalpendingstaffs)
                          : widget.pagecollectiontype ==
                                  DbPaths.collectionpartners
                              ? (accountSTATUS == Dbkeys.sTATUSallowed
                                  ? Dbkeys.totalapprovedpartners
                                  : accountSTATUS == Dbkeys.sTATUSblocked
                                      ? Dbkeys.totalblockedpartners
                                      : Dbkeys.totalpendingpartners)
                              : null,
                )
                    .then((value) async {
                  //-- CREATED HISTORY
                  if (AppConstants.isrecordhistory == true) {
                    await FirebaseApi().runUPDATEtransactionWithQuantityCheck(
                        isshowmsg: false,
                        context: context,
                        scaffoldkey: _scaffoldKey,
                        isusesecondfn: false,
                        // keyloader: _keyLoader4,
                        isshowloader: false,
                        totaldeleterange: 200,
                        totallimitfordelete: 700,
                        newmap: {
                          Dbkeys.nOTIFICATIONxxdesc: accountSTATUS ==
                                  Dbkeys.sTATUSallowed
                              ? '$fullname (${widget.pagekeyword}) account is Blocked for the Reason: ${_controller.text.trim()}. By- ${session.fullname} from ${AppConstants.apptype} '
                              : accountSTATUS == Dbkeys.sTATUSpending
                                  ? '$fullname (${widget.pagekeyword}) account is Approved. By- ${session.fullname} from ${AppConstants.apptype} '
                                  : accountSTATUS == Dbkeys.sTATUSblocked
                                      ? '$fullname (${widget.pagekeyword}) account Block is removed. By- ${session.fullname} from ${AppConstants.apptype} '
                                      : '$fullname (${widget.pagekeyword}) account status is changed. By- ${session.fullname} from ${AppConstants.apptype} ',
                          Dbkeys.nOTIFICATIONxxtitle:
                              accountSTATUS == Dbkeys.sTATUSallowed
                                  ? 'Account BLOCKED'
                                  : accountSTATUS == Dbkeys.sTATUSpending
                                      ? 'Account APPROVED'
                                      : accountSTATUS == Dbkeys.sTATUSblocked
                                          ? 'Account APPROVED'
                                          : 'Account Status changed',
                          Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
                          Dbkeys.nOTIFICATIONxxauthor:
                              session.uid + 'XXX' + AppConstants.apptype,
                          Dbkeys.nOTIFICATIONxxextrafield: userid,
                        });
                  }
                }).then((value) async {
                  await firestore.updateparticulardocinProvider(
                      context: context,
                      scaffoldkey: _scaffoldKey,
                      compareKey: Dbkeys.uSERphone,
                      compareVal: userid,
                      collection: widget.pagecollectiontype!,
                      document: userid);
                  ShowLoading().close(context: context, key: _keyLoader);
                  _controller.clear();

                  // setState(() {});
                  ShowSnackbar().open(
                      context: context,
                      scaffoldKey: _scaffoldKey,
                      status: 2,
                      time: 3,
                      label: accountSTATUS == Dbkeys.sTATUSallowed
                          ? 'Success !  ${fullname!.toUpperCase()} is Blocked. User will be notified automatically.'
                          : accountSTATUS == Dbkeys.sTATUSblocked
                              ? 'Success !  ${fullname!.toUpperCase()} is Allowed. User will be notified automatically.'
                              : 'Success !  ${fullname!.toUpperCase()} is Approved & Allowed. User will be notified automatically.');
                });
              });
            })
        .catchError((error) {
      ShowLoading().close(context: context, key: _keyLoader);
      _controller.clear();
      // print('Erssssror:${observer.isshowerrorlog} $error');
      ShowSnackbar().open(
          context: context,
          scaffoldKey: _scaffoldKey,
          status: 1,
          time: 3,
          label: observer.isshowerrorlog == false
              ? 'Error Ocuured and Task failed.\nPlease try again !'
              : 'Error Occured : $error. Please try again !');
    });
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>(debugLabel: '0000');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  searchWidget(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
var tabBar= TabBar(
  indicatorColor:Mycolors.green,
  labelColor: Mycolors.greenbuttoncolor,
        tabs: [
          Tab(icon: Icon(Icons.flight)),
          Tab(icon: Icon(Icons.directions_transit)),
          // Tab(icon: Icon(Icons.directions_car)),
        ],
      );
      TabBarView(
        controller: tabController,
        children: [

        ],
      );
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          // return your layout
          return Container(
            padding: EdgeInsets.all(3),
            height: 200,
            child: Column(children: [
              SizedBox(
                height: 18,
              ),
              MtCustomfontBold(
                color: Mycolors.black,
                fontsize: 18,
                text: 'Search a User',
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myinkwell(
                    onTap: () {
                      Navigator.of(context).pop();
                      pageNavigator(context, SearchUserByName());
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: w / 3.35,
                      decoration: boxDecoration(
                        showShadow: true,
                        radius: 7,
                        bgColor: Mycolors.pink,
                      ),
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sort_by_alpha_outlined,
                              size: 28, color: Mycolors.yellow),
                          SizedBox(
                            height: 7,
                          ),
                          MtCustomfontMedium(
                            text: 'Search by Name',
                            color: Colors.white,
                            textalign: TextAlign.center,
                            lineheight: 1.3,
                          )
                        ],
                      ),
                    ),
                  ),
                  myinkwell(
                    onTap: () {
                      Navigator.of(context).pop();
                      pageNavigator(context, SearchUser(searchtype: 'byphone'));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: w / 3.35,
                      decoration: boxDecoration(
                        showShadow: true,
                        radius: 7,
                        bgColor: Mycolors.purple,
                      ),
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_enabled,
                              size: 28, color: Mycolors.yellow),
                          SizedBox(
                            height: 7,
                          ),
                          MtCustomfontMedium(
                            text: 'Search by Phone ',
                            color: Colors.white,
                            textalign: TextAlign.center,
                            lineheight: 1.3,
                          )
                        ],
                      ),
                    ),
                  ),
                  myinkwell(
                      onTap: () {
                        Navigator.of(context).pop();
                        pageNavigator(context, SearchUser(searchtype: 'byuid'));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: w / 3.35,
                        decoration: boxDecoration(
                          showShadow: true,
                          radius: 7,
                          bgColor: Mycolors.orange,
                        ),
                        height: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.perm_identity_outlined,
                                size: 28,
                                color: Colors.yellowAccent.withOpacity(0.8)),
                            SizedBox(
                              height: 9,
                            ),
                            MtCustomfontMedium(
                              text: 'Search by\nUID',
                              color: Colors.white,
                              textalign: TextAlign.center,
                              lineheight: 1.3,
                            )
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          );
        });
  }

  sort(BuildContext context, String sortby) {
    final firestore =
        Provider.of<FirestoreDataProviderUSERS>(context, listen: false);
    switch (sortby) {
      case Dbkeys.sortbyBLOCKED:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .where(Dbkeys.uSERaccountstatus, isEqualTo: Dbkeys.sTATUSblocked)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
        break;
      case Dbkeys.sortbyAPPROVED:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .where(Dbkeys.uSERaccountstatus, isEqualTo: Dbkeys.sTATUSallowed)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
        break;
      case Dbkeys.sortbyPENDING:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .where(Dbkeys.uSERaccountstatus, isEqualTo: Dbkeys.sTATUSpending)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
        break;
      case Dbkeys.sortbyALLUSERS:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .orderBy(Dbkeys.uSERjoinedon, descending: true)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
        break;
      case Dbkeys.sortbyALLUSERS:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .orderBy(Dbkeys.uSERjoinedon, descending: true)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
        break;
      case Dbkeys.sortbyUSERSONLINE:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .where(Dbkeys.uSERlastseen, isEqualTo: true)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
        break;
      default:
        {
          query = FirebaseFirestore.instance
              .collection(widget.pagecollectiontype!)
              .orderBy(Dbkeys.uSERjoinedon, descending: true)
              .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore);
        }
    }
    setState(() {});
    firestore.reset();
    firestore.fetchNextData(Dbkeys.dataTypeUSERS, query, true);
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Utils.getNTPWrappedWidget(Consumer<Observer>(
          builder: (context, observer, _child) => Consumer<CommonSession>(
                builder: (context, session, _child) =>
                    Consumer<FirestoreDataProviderUSERS>(
                  builder: (context, firestoreDataProvider, _) {
                      List doctorsList=[];
                      List patientData=[];
                    if(firestoreDataProvider.recievedDocs.isNotEmpty){
                      for(int i=0;i<firestoreDataProvider.recievedDocs.length;i++){
                        if(firestoreDataProvider.recievedDocs[i]["specialization"]!="[]"){
                         doctorsList.add(firestoreDataProvider.recievedDocs[i]);
                        }else{
                         patientData.add(firestoreDataProvider.recievedDocs[i]);

                        }
                      }
                    }
                    // (firestoreDataProvider.recievedDocs;)
                    return MyScaffold(
                      showTabBar: true,
                      isforcehideback: true,
                      scaffoldkey: _scaffoldKey,
                      title: '${widget.pagekeyword}',
                      iconWidget: PopupMenuButton<String>(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 6, 10, 9),
                          child: Icon(EvaIcons.listOutline),
                        ),
                        onSelected: (choice) {
                          print(choice);
                          sort(context, choice);
                        },
                        itemBuilder: (BuildContext context) {
                          return {
                            Dbkeys.sortbyALLUSERS,
                            Dbkeys.sortbyAPPROVED,
                            Dbkeys.sortbyBLOCKED,
                            Dbkeys.sortbyPENDING,
                            Dbkeys.sortbyUSERSONLINE,
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(
                                choice,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList();
                        },
                      ),
                      icon1press: () {},
                      icondata2: Icons.search,
                      icon2press: () {
                        searchWidget(context);
                      },

                      body: InfiniteCOLLECTIONListViewWidget(
                        firestoreDataProviderUSERS: firestoreDataProvider,
                        datatype: Dbkeys.dataTypeUSERS,
                        refdata: query,
                        list: ListView.builder(
                            padding: EdgeInsets.all(0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            // itemCount:
                                // firestoreDataProvider.recievedDocs.length,
                                itemCount:doctorsList.length,
                            itemBuilder: (BuildContext context, int i) {
                              // var dc = firestoreDataProvider.recievedDocs[i];
                              var dc = doctorsList[i];

                              // log("specialization${dc["specialization"]}");

                              return UserCard(
                                isProfileFetchedFromProvider: true,
                                onswitchchanged: AppConstants.isdemomode == true
                                    ? (val) {
                                        Utils.toast('Not Allowed in Demo App');
                                      }
                                    : (val) async {
                                        await confirmchangeswitch(
                                          context,
                                          dc[Dbkeys.uSERaccountstatus] ??
                                              Dbkeys.sTATUSallowed,
                                          dc[Dbkeys.uSERphone],
                                          dc[Dbkeys.uSERfullname],
                                          dc[Dbkeys.uSERphotourl],
                                        );
                                      },
                                docMap: dc,
                              );
                            }),
                      ),
                      patient: InfiniteCOLLECTIONListViewWidget(
                        firestoreDataProviderUSERS: firestoreDataProvider,
                        datatype: Dbkeys.dataTypeUSERS,
                        refdata: query,
                        list: ListView.builder(
                            padding: EdgeInsets.all(0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            // itemCount:
                                // firestoreDataProvider.recievedDocs.length,
                                itemCount:patientData.length,
                            itemBuilder: (BuildContext context, int i) {
                              // var dc = firestoreDataProvider.recievedDocs[i];
                              var dc = patientData[i];

                              // log("specialization${dc["specialization"]}");

                              return UserCard(
                                isProfileFetchedFromProvider: true,
                                onswitchchanged: AppConstants.isdemomode == true
                                    ? (val) {
                                        Utils.toast('Not Allowed in Demo App');
                                      }
                                    : (val) async {
                                        await confirmchangeswitch(
                                          context,
                                          dc[Dbkeys.uSERaccountstatus] ??
                                              Dbkeys.sTATUSallowed,
                                          dc[Dbkeys.uSERphone],
                                          dc[Dbkeys.uSERfullname],
                                          dc[Dbkeys.uSERphotourl],
                                        );
                                      },
                                docMap: dc,
                              );
                            }),
                      )
  ,
                      );
                      
                       
                            

  }),
              ))),
    );
  
  }
}
