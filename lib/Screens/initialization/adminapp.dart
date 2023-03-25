import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thinkcreative_technologies/Screens/authentication/AdminAuth.dart';
import 'package:thinkcreative_technologies/Screens/bottomnavbar/BottomNavBarAdminApp.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/ConnectivityServices.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreCOLLECTIONDataProvider.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreDOCUMENTDataProvider.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Services/providers/BottomNavBar.dart';
import 'package:thinkcreative_technologies/Services/providers/DownloadInfoProvider.dart';

import '../dashboard/AdminDashboard.dart';

class AdminApp extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> doc;
  AdminApp({required this.doc});
  @override
  Widget build(BuildContext context) {

    // MultiProvider for top-level services that can be created right away
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Observer>(
            create: (BuildContext context) {
              return Observer();
            },
          ),

          ChangeNotifierProvider<FirestoreDataProviderREPORTS>(
            create: (BuildContext context) {
              return FirestoreDataProviderREPORTS();
            },
          ),
          ChangeNotifierProvider<FirestoreDataProviderUSERS>(
            create: (BuildContext context) {
              return FirestoreDataProviderUSERS();
            },
          ),
          ChangeNotifierProvider<FirestoreDataProviderCALLHISTORY>(
            create: (BuildContext context) {
              return FirestoreDataProviderCALLHISTORY();
            },
          ),
          ChangeNotifierProvider<FirestoreDataProviderDocNOTIFICATION>(
            create: (BuildContext context) {
              return FirestoreDataProviderDocNOTIFICATION();
            },
          ),

          ChangeNotifierProvider<CommonSession>(
            create: (BuildContext context) {
              return CommonSession();
            },
          ),
          ChangeNotifierProvider<DownloadInfoprovider>(
            create: (BuildContext context) {
              return DownloadInfoprovider();
            },
          ),
          //---- All the above providers are AUTHENTICATION PROVIDER -------

          ChangeNotifierProvider<BottomNavigationBarProvider>(
            create: (BuildContext context) {
              return BottomNavigationBarProvider();
            },
          ),
        ],
        child: StreamProvider<ConnectivityStatus>(
            initialData: ConnectivityStatus.Cellular,
            create: (context) =>
                ConnectivityService().connectionStatusController.stream,
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                // home: Admindashboard(),
                home: MyBottomNavBarAdminApp(isFirstTimeSetup: false),
                // home: AdminAauth(
                //   doc: doc,
                // )
                )));
  }
}
