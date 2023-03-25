import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Screens/reports/allreports.dart';
import 'package:thinkcreative_technologies/Services/providers/BottomNavBar.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Screens/networkSensitiveUi/NetworkSensitiveUi.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:thinkcreative_technologies/Widgets/CustomCard.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Widgets/MyInkWell.dart';
import 'package:thinkcreative_technologies/Widgets/avatars/customCircleAvatars.dart';
import 'package:thinkcreative_technologies/Widgets/dashboardElements/dashboardwidgets.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';
import 'package:thinkcreative_technologies/Widgets/tiles.dart';

import '../withdraw/withdraw.dart';

class Admindashboard extends StatefulWidget {
  @override
  _AdmindashboardState createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_hhssssh');
  bool isloading = true;
  List recent5users = [];
  bool isSeenAllCountries = false;
  late Query countrywisequery;
  @override
  void initState() {
    super.initState();
    fetchData();
    countrywisequery = FirebaseFirestore.instance
        .collection(Dbkeys.countrywisedata)
        .orderBy('totalusers', descending: true)
        .limit(6);
    // configurePushNotification();
  }

  setTemporaryUnavailable(String message) async {
    // print(message);

    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      )),
    );
  }

  fetchData() async {
    final session = Provider.of<CommonSession>(context, listen: false);
    await FirebaseFirestore.instance
        .collection(Dbkeys.appsettings)
        .doc(Dbkeys.userapp)
        .get()
        .then((userSettingsDoc) async {
      if (userSettingsDoc.exists) {
        if (userSettingsDoc.data()!.containsKey(Dbkeys.usersidesetupdone)) {
          print('a2');
          await FirebaseFirestore.instance
              .collection(DbPaths.collectiondashboard)
              .doc(DbPaths.docuserscount)
              .get()
              .then((userCountDoc) async {
            if (userCountDoc.exists) {
              print('a3');
              await FirebaseFirestore.instance
                  .collection(DbPaths.collectiondashboard)
                  .doc(DbPaths.docchatdata)
                  .get()
                  .then((chatDataDoc) async {
                if (chatDataDoc.exists) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .orderBy(Dbkeys.uSERjoinedon, descending: true)
                      .limit(5)
                      .get()
                      .then((users) {
                    print('a4');
                    if (mounted) {
                      setState(() {
                        session.setData(
                          newuserSettings: userSettingsDoc.data(),
                          newuserCount: userCountDoc.data(),
                          newchatData: chatDataDoc.data(),
                        );

                        recent5users = users.docs;
                        log("user docs${users.docs}");
                        isloading = false;
                      });
                    }
                  });
                } else {
                  Utils.toast(
                      "User App is not setup yet. Kindly Install the User App from Codecanyon Source code.");
                  setTemporaryUnavailable(
                      'User app  is not linked to admin app properly (chatDataDoc does not exists). To Link admin app, follow these steps:\n\n1. You need to update the User app.\n\n2. Set \"ConnectWithAdminApp\" to true inside lib/configs/App_constants.dart file.\n\n3. Run & Built the new app. Please Make sure you have upgraded the new app version number to trigger Update popup for users (mandatory).\n\n4. After the user app gets built, Open the app and it will stuck at the launch screen for a minute. It will link with admin app automatically. \n\n 5.If there are more than 50 users already registered the app, it is going to take some time.  \n\n 6. Wait for the process until, you see the Login screen appeared.  \n\n7. All Done !User app will be linked successfuly to admin app.  \n\n8. Enjoy the Admin app.');
                }
              });
            } else {
              Utils.toast(
                  "User App is not setup yet. Kindly Install the User App from Codecanyon Source code.");
              setTemporaryUnavailable(
                  'User app  is not linked to admin app properly (userCountDoc does not exists). To Link admin app, follow these steps:\n\n1. You need to update the User app.\n\n2. Set \"ConnectWithAdminApp\" to true inside lib/configs/App_constants.dart file.\n\n3. Run & Built the new app. Please Make sure you have upgraded the new app version number to trigger Update popup for users (mandatory).\n\n4. After the user app gets built, Open the app and it will stuck at the launch screen for a minute. It will link with admin app automatically. \n\n 5.If there are more than 50 users already registered the app, it is going to take some time.  \n\n 6. Wait for the process until, you see the Login screen appeared.  \n\n7. All Done !User app will be linked successfuly to admin app.  \n\n8. Enjoy the Admin app.');
            }
          });
        } else {
          Utils.toast(
              "User App is not setup yet. Kindly Install the User App from Codecanyon Source code.");
          setTemporaryUnavailable(
              'User app  is not linked to admin app properly [containsKey(${Dbkeys.usersidesetupdone}) does not exists]. To Link admin app, follow these steps:\n\n1. You need to update the User app.\n\n2. Set \"ConnectWithAdminApp\" to true inside lib/configs/App_constants.dart file.\n\n3. Run & Built the new app. Please Make sure you have upgraded the new app version number to trigger Update popup for users (mandatory).\n\n4. After the user app gets built, Open the app and it will stuck at the launch screen for a minute. It will link with admin app automatically. \n\n 5.If there are more than 50 users already registered the app, it is going to take some time.  \n\n 6. Wait for the process until, you see the Login screen appeared.  \n\n7. All Done !User app will be linked successfuly to admin app.  \n\n8. Enjoy the Admin app.');
        }
      } else {
        Utils.toast(
            "User App is not setup yet. Kindly Install the User App from Codecanyon Source code.");
        setTemporaryUnavailable(
            'User app  is not linked to admin app yet (userSettingsDoc does not exists). To Link admin app, follow these steps:\n\n1. You need to update the User app.\n\n2. Set \"ConnectWithAdminApp\" to true inside lib/configs/App_constants.dart file.\n\n3. Run & Built the new app. Please Make sure you have upgraded the new app version number to trigger Update popup for users (mandatory).\n\n4. After the user app gets built, Open the app and it will stuck at the launch screen for a minute. It will link with admin app automatically. \n\n 5.If there are more than 50 users already registered the app, it is going to take some time.  \n\n 6. Wait for the process until, you see the Login screen appeared.  \n\n7. All Done !User app will be linked successfuly to admin app.  \n\n8. Enjoy the Admin app.');
      }
    }).catchError((err) {
      print(err);
      setTemporaryUnavailable(
          'Unable to fetch the User app due to an error. Please try again.\n\nERROR: $err');
    });
  }

  Future getcountrywisedata(Query query) async {
    QuerySnapshot qn = await query.get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    double expandHeight = 257;
    double w = MediaQuery.of(context).size.width;

    return NetworkSensitive(
        child: Utils.getNTPWrappedWidget(
      Consumer<Observer>(
          builder: (context, observer, _child) => Consumer<CommonSession>(
              builder: (context, session, _child) => Consumer<
                      BottomNavigationBarProvider>(
                  builder: (context, provider, _child) => Container(
                        color: Mycolors.primary,
                        child: SafeArea(
                          child: Scaffold(
                            backgroundColor: Mycolors.backgroundcolor,
                            key: _scaffoldKey,
                            body: isloading == true
                                ? circularProgress()
                                : 
                                NestedScrollView(
                                    headerSliverBuilder: (BuildContext context,
                                        bool innerBoxIsScrolled) {
                                      return <Widget>[
                                        SliverAppBar(
                                          expandedHeight: expandHeight,
                                          floating: true,
                                          forceElevated: innerBoxIsScrolled,
                                          pinned: true,
                                          titleSpacing: 0,
                                          backgroundColor: innerBoxIsScrolled
                                              ? Mycolors.primary
                                              : Mycolors.primary,
                                          actionsIconTheme:
                                              IconThemeData(opacity: 0.0),
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 8, 2, 0),
                                            child: MtPoppinsBold(
                                              text: 'Dashboard',
                                              fontsize: 20,
                                              color: Mycolors.white,
                                            ),
                                          ),
                                          actions: [
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.fromLTRB(
                                            //           10, 13, 13, 10),
                                            //   child: myinkwell(
                                            //     onTap: () {
                                            //       provider.setcurrentIndex(4);
                                            //     },
                                            //     child: customCircleAvatar(
                                            //         radius: 17,
                                            //         url: session.photourl),
                                            //   ),
                                            // ),
                                          ],
                                          flexibleSpace: FlexibleSpaceBar(
                                            background: Container(
                                              height: expandHeight,
                                              margin: EdgeInsets.only(top: 60),
                                              color: Mycolors.primary,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      dashboardCard(
                                                          width: w / 2.3,
                                                          cardColor:
                                                              Color(0xfff29b38),
                                                          label: 'Audio Calls',
                                                          value:
                                                              '${session.chatData['audiocallsmade']}',
                                                          iconData:
                                                              Icons.phone),
                                                      dashboardCard(
                                                          width: w / 2.3,
                                                          cardColor:
                                                              Color(0xffe15141),
                                                          label: 'Video Calls',
                                                          value:
                                                              '${session.chatData['videocallsmade']}',
                                                          iconData:
                                                              Icons.video_call),
                                                    ],
                                                  ),
                                                
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      dashboardCard(
                                                        width: w / 3.6,
                                                        iconData: Icons.people,
                                                        cardColor:
                                                            Color(0xff67ac5b),
                                                        label: 'Users',
                                                        value:
                                                            '${session.userCount[Dbkeys.totalapprovedusers] + session.userCount[Dbkeys.totalblockedusers]}',
                                                      ),
                                                      dashboardCard(
                                                          width: w / 3.6,
                                                          cardColor:
                                                              Color(0xff49a6ef),
                                                          label: 'Media',
                                                          value:
                                                              '${session.chatData[Dbkeys.mediamessagessent]}',
                                                          iconData:
                                                              Icons.play_arrow),
                                                      dashboardCard(
                                                          width: w / 3.6,
                                                          cardColor:
                                                              Color(0xff9737b3),
                                                          label: 'Visits',
                                                          value:
                                                              '${session.userCount[Dbkeys.totalvisitsANDROID] + session.userCount[Dbkeys.totalvisitsIOS]}',
                                                          iconData: Icons
                                                              .trending_up),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                     
                                      ];
                                    },
                                    body: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Padding(
                                            //   padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 16),
                                            //   child: text(db6_lbl_top_services, fontFamily: fontBold, fontSize: textSizeNormal),
                                            // ),

                                            // Container(
                                            //   margin: EdgeInsets.all(5),
                                            //   color: Colors.transparent,
                                            //   padding: EdgeInsets.all(2),
                                            //   child: GridView(
                                            //     physics: ScrollPhysics(),
                                            //     shrinkWrap: true,
                                            //     children: [
                                            //       eachGridTile(
                                            //           label: 'Calls\nAllowed',
                                            //           width: w,
                                            //           isallowed: session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .iscallsallowed]),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Messaging\n Allowed',
                                            //           width: w,
                                            //           isallowed: session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .istextmessageallowed]),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Send Media\nAllowed',
                                            //           width: w,
                                            //           isallowed: session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .ismediamessageallowed]),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Allow New\nLogins',
                                            //           width: w,
                                            //           isallowed: !session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .isblocknewlogins]),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Emulator\nAllowed',
                                            //           width: w,
                                            //           isallowed: session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .isemulatorallowed]),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Collect\nDevice Info',
                                            //           width: w,
                                            //           isallowed: true),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Update\nMandatory',
                                            //           width: w,
                                            //           isallowed: true),
                                            //       eachGridTile(
                                            //           label:
                                            //               'Android Maintainance',
                                            //           width: w,
                                            //           isallowed: session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .isappunderconstructionandroid]),
                                            //       eachGridTile(
                                            //           label: 'iOS Maintainance',
                                            //           width: w,
                                            //           isallowed: session
                                            //                   .userSettings[
                                            //               Dbkeys
                                            //                   .isappunderconstructionios])
                                            //     ],
                                            //     gridDelegate:
                                            //         SliverGridDelegateWithFixedCrossAxisCount(
                                            //             crossAxisCount: 3,
                                            //             childAspectRatio: 1.1,
                                            //             mainAxisSpacing: 4,
                                            //             crossAxisSpacing: 4),
                                            //     padding: EdgeInsets.all(2),
                                            //   ),
                                            // ),
                                            
                                            Container(
                                              color: Colors.transparent,
                                              padding: EdgeInsets.all(2),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            customcardStatistics(
                                                onTap: () {},
                                                cardcolor: Color(0xFF282A4D),
                                                cardcolorInner:
                                                    Color(0xFF2D325A),
                                                context: context,
                                                l: '${session.userCount[Dbkeys.totalapprovedusers] + session.userCount[Dbkeys.totalblockedusers] + session.userCount[Dbkeys.totalpendingusers]}',
                                                lbase: 'Total Users',
                                                r1: '${session.userCount[Dbkeys.totalapprovedusers]}',
                                                r1base: 'Approved ',
                                                r2: '${session.userCount[Dbkeys.totalblockedusers]}',
                                                r2base: 'Blocked'),
                                           
                                            SizedBox(
                                              height: 15,
                                            ),
                                            customcardVersionControl(
                                              cardcolor: Mycolors.white,
                                              cardcolorInner: Mycolors
                                                  .greylightcolor
                                                  .withOpacity(0.5),
                                              context: context,
                                              androidUserappVersion:
                                                  '${session.userSettings[Dbkeys.latestappversionandroid]}',
                                              iosUserappVersion:
                                                  '${session.userSettings[Dbkeys.latestappversionios]}',
                                              // androidAdminappVersion:
                                              //     '${session.adminSettings[Dbkeys.latestappversionandroid]}',
                                              // iosAdminappVersion:
                                              //     '${session.adminSettings[Dbkeys.latestappversionios]}',
                                            ),

                                            // MaterialButton(
                                            //   // color: Colors.black,
                                            //   onPressed: () async {
                                            //   await FirebaseFirestore.instance
                                            //       .collection('users')
                                            //       .get()
                                            //       .then((users) async {
                                            //     users.docs.forEach((doc) async {
                                            //       await FirebaseFirestore
                                            //           .instance
                                            //           .collection('users')
                                            //           .doc(doc.reference.id)
                                            //           .collection(DbPaths
                                            //               .collectionnotifications)
                                            //           .doc(DbPaths
                                            //               .collectionnotifications)
                                            //           .set({
                                            //         Dbkeys.nOTIFICATIONxxtitle:
                                            //             '',
                                            //         Dbkeys.nOTIFICATIONxxdesc:
                                            //             '',
                                            //         Dbkeys.nOTIFICATIONxxaction:
                                            //             Dbkeys
                                            //                 .nOTIFICATIONactionPUSH,
                                            //         Dbkeys.nOTIFICATIONxximageurl:
                                            //             '',
                                            //         Dbkeys.nOTIFICATIONxxlastupdate:
                                            //             DateTime.now(),
                                            //         Dbkeys.nOTIFICATIONxxpagecomparekey:
                                            //             Dbkeys.docid,
                                            //         Dbkeys.nOTIFICATIONxxpagecompareval:
                                            //             '',
                                            //         Dbkeys.nOTIFICATIONxxparentid:
                                            //             '',
                                            //         Dbkeys.nOTIFICATIONxxextrafield:
                                            //             '',
                                            //         Dbkeys.nOTIFICATIONxxpagetype:
                                            //             Dbkeys
                                            //                 .nOTIFICATIONpagetypeSingleLISTinDOCSNAP,
                                            //         Dbkeys.nOTIFICATIONxxpageID:
                                            //             'users',
                                            //         //-----
                                            //         Dbkeys.nOTIFICATIONpagecollection1:
                                            //             'users',
                                            //         Dbkeys.nOTIFICATIONpagedoc1:
                                            //             doc.reference.id,
                                            //         Dbkeys.nOTIFICATIONpagecollection2:
                                            //             DbPaths
                                            //                 .collectionnotifications,
                                            //         Dbkeys.nOTIFICATIONpagedoc2:
                                            //             DbPaths
                                            //                 .collectionnotifications,
                                            //         Dbkeys.nOTIFICATIONtopic:
                                            //             'PUSER',
                                            //         Dbkeys.list: [],
                                            //       });
                                            //     });
                                            //   });
                                            // }),
                                            
                                            Container(
                                              // color: Mycolors.white,
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 20, 0, 10),
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          16, 8, 2, 13),
                                                      child: MtCustomfontBold(
                                                          text:
                                                              'Recently Joined ',
                                                          fontsize: 16),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              6, 0, 6, 0),
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      // height: 110,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              recent5users
                                                                  .length,
                                                          shrinkWrap: true,
                                                          physics:
                                                              ScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return UserCard(
                                                              isProfileFetchedFromProvider:
                                                                  false,
                                                              docMap:
                                                                  recent5users[
                                                                          index]
                                                                      .data(),
                                                              isswitchshow:
                                                                  false,
                                                            );
                                                          }),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: OutlinedButton(
                                                        child: new Text(
                                                          "See more users",
                                                          style: TextStyle(
                                                              color: Mycolors
                                                                  .black),
                                                        ),
                                                        onPressed: () {
                                                          provider
                                                              .setcurrentIndex(
                                                                  1);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                // height: 190,
                                                child: FutureBuilder(
                                                  future: getcountrywisedata(
                                                      countrywisequery),
                                                  builder: (_,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Mycolors
                                                                        .loadingindicator)),
                                                      );
                                                    } else if (snapshot
                                                            .hasData ==
                                                        true) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    16,
                                                                    18,
                                                                    2,
                                                                    13),
                                                            child: MtCustomfontBold(
                                                                text: isSeenAllCountries ==
                                                                        true
                                                                    ? 'All ${snapshot.data.length} User Countries'
                                                                    : 'Top 6 User Countries ',
                                                                fontsize: 16),
                                                          ),
                                                          GridView.builder(
                                                            itemCount: snapshot
                                                                .data.length,
                                                            physics:
                                                                ScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int i) {
                                                              return eachCountryTile(
                                                                  count: snapshot
                                                                          .data[i]
                                                                      [
                                                                      'totalusers'],
                                                                  countrycode:
                                                                      snapshot
                                                                          .data[
                                                                              i]
                                                                          .id,
                                                                  width: w);
                                                            },
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                childAspectRatio:
                                                                    1.1,
                                                                mainAxisSpacing:
                                                                    4,
                                                                crossAxisSpacing:
                                                                    4),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Mycolors
                                                                        .loadingindicator)),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            isSeenAllCountries == true
                                                ? SizedBox(
                                                    height: 0,
                                                  )
                                                : Center(
                                                    child: OutlinedButton(
                                                      child: new Text(
                                                        "See all Countries",
                                                        style: TextStyle(
                                                            color:
                                                                Mycolors.black),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          countrywisequery =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(Dbkeys
                                                                      .countrywisedata)
                                                                  .orderBy(
                                                                      'totalusers',
                                                                      descending:
                                                                          true);
                                                          isSeenAllCountries =
                                                              true;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            AppConstants.isdemomode == true
                                                ? SizedBox()
                                                : Center(
                                                    child: MySimpleButton(
                                                      onpressed: () {
                                                        pageNavigator(context,
                                                            AllReports());
                                                      },
                                                      spacing: 0.3,
                                                      buttontext:
                                                          'Reports by Users',
                                                      icon: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: AppConstants.isdemomode ==
                                                      true
                                                  ? 0
                                                  : 30,
                                            ),
                                            Center(
                                              child: MySimpleButton(
                                                onpressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              WithdrawPage()));
                                                },
                                                spacing: 0.3,
                                                buttontext:
                                                    'WithDraw Requests ',
                                                icon: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: AppConstants.isdemomode ==
                                                      true
                                                  ? 0
                                                  : 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                 
                                  ),
                          
                          ),
                        ),
                      )))),
    ));
 
  }
}
