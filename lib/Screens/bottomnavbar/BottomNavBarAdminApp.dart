import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:thinkcreative_technologies/Screens/dashboard/AdminDashboard.dart';
import 'package:thinkcreative_technologies/Screens/authentication/ChangeLoginCredentials.dart';
import 'package:thinkcreative_technologies/Screens/authentication/AdminAccount.dart';
import 'package:thinkcreative_technologies/Screens/settings/SettingsPage.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Screens/notifications/AllNotifications.dart';
import 'package:thinkcreative_technologies/Screens/users/AllUsers.dart';
import 'package:thinkcreative_technologies/Services/providers/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Widgets/MySharedPrefs.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/doubleTapBack/doubleTapBack.dart';

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

class MyBottomNavBarAdminApp extends StatefulWidget {
  final bool isFirstTimeSetup;
  MyBottomNavBarAdminApp({required this.isFirstTimeSetup});
  @override
  _MyBottomNavBarAdminAppState createState() => _MyBottomNavBarAdminAppState();
}

class _MyBottomNavBarAdminAppState extends State<MyBottomNavBarAdminApp> {
// List<BottomNavigationBarProvider> bottomtabs=[];
  var currentTab = [
    Admindashboard(),
    AllUsers(
      pagecollectiontype: DbPaths.collectionusers,
      pagekeyword: 'Users',
      preloadedQuery: FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .orderBy(Dbkeys.uSERjoinedon, descending: true)
          .limit(Numberlimits.totalDatatoLoadAtOnceFromFirestore),
    ),
    SettingsPage(
      isforcehideleading: true,
    ),
    NotificationCentre(),
    AdminAccount(),
  ];
  bool setupdone = true;

  @override
  void initState() {
    super.initState();

    MySharedPrefs().setmybool('isLoggedIn', true);

    if (widget.isFirstTimeSetup == true) {
      setState(() {
        setupdone = false;
      });
    }
    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);

    registerToNotifications();
    configurePushNotification();
  }

  registerToNotifications() async {
    await FirebaseMessaging.instance.subscribeToTopic(Dbkeys.topicADMIN);
  }

//----- -------------------- -----

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);

    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return WillPopScope(
        onWillPop: doubleTapTrigger,
        child: WillPopScope(
            onWillPop: doubleTapTrigger,
            child: setupdone == false
                ? ChangeLoginCredentials(
                    isFirstTime: true,
                    callbackOnUpdate: () {
                      setState(() {
                        setupdone = true;
                      });
                    },
                  )
                : Scaffold(
                    body: currentTab[provider.currentInd],
                    bottomNavigationBar: BottomNavigationBar(
                      selectedItemColor: Mycolors.bottomappbaricontext,
                      backgroundColor: Colors.white,
                      type: BottomNavigationBarType.fixed,
                      selectedFontSize: 11.0,
                      unselectedFontSize: 11,
                      unselectedItemColor: Mycolors.grey,
                      key: navBarGlobalKey,
                      currentIndex: provider.currentInd,
                      onTap: (index) {
                        provider.setcurrentIndex(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.dashcube,
                              size: 25,
                              color: Mycolors.grey,
                            ),
                          ),
                          label: 'Dashboard',
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.dashcube,
                              size: 25,
                              color: Mycolors.bottomappbaricontext,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.users,
                              size: 25,
                              color: Mycolors.grey,
                            ),
                          ),
                          label: 'Users',
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.users,
                              size: 25,
                              color: Mycolors.bottomappbaricontext,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.discord,
                              size: 25,
                              color: Mycolors.grey,
                            ),
                          ),
                          label: 'Settings',
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.discord,
                              size: 25,
                              color: Mycolors.bottomappbaricontext,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.bell,
                              size: 25,
                              color: Mycolors.grey,
                            ),
                          ),
                          label: 'Notifications',
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Icon(
                              LineAwesomeIcons.bell,
                              size: 25,
                              color: Mycolors.bottomappbaricontext,
                            ),
                          ),
                        ),
                        // BottomNavigationBarItem(
                        //   icon: Padding(
                        //     padding: const EdgeInsets.only(top: 3, bottom: 3),
                        //     child: Icon(
                        //       LineAwesomeIcons.user,
                        //       size: 25,
                        //       color: Mycolors.grey,
                        //     ),
                        //   ),
                        //   label: 'Account',
                        //   activeIcon: Padding(
                        //     padding: const EdgeInsets.only(top: 3, bottom: 3),
                        //     child: Icon(
                        //       LineAwesomeIcons.user,
                        //       size: 25,
                        //       color: Mycolors.bottomappbaricontext,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )));
  }

  configurePushNotification() async {
    //ANDROID & iOS  OnMessage callback
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('onmessagecallback');
      // ignore: unnecessary_null_comparison
      if (message.data != null) {
        final provider =
            Provider.of<BottomNavigationBarProvider>(context, listen: false);

        ShowCustomAlertDialog().open(
            context: context,
            dialogtype: 'notification',
            title: 'New Notification',
            leftbuttontext: 'SEE NOTIFICATION',
            leftbuttoncolor: Mycolors.primary,
            leftbuttononpress: () {
              provider.setcurrentIndex(3);
            },
            description: message.data['body']);
        print(message.toString());
      }
    });
    //ANDROID & iOS  onMessageOpenedApp callback
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // ignore: unnecessary_null_comparison
      if (message != null) {
        final provider =
            Provider.of<BottomNavigationBarProvider>(context, listen: false);
        provider.setcurrentIndex(1);
        print(message.toString());
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final provider =
            Provider.of<BottomNavigationBarProvider>(context, listen: false);
        provider.setcurrentIndex(1);
        print(message.toString());
      }
    });
  }
}
