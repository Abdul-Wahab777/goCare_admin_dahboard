import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Screens/settings/EditAdminAppSettings.dart';
import 'package:thinkcreative_technologies/Screens/settings/EditUserAppSettings.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/eachtile.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';

class SettingsPage extends StatefulWidget {
  final bool isforcehideleading;
  SettingsPage({required this.isforcehideleading});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      isforcehideback: widget.isforcehideleading,
      titlespacing: 15,
      title: 'Settings',
      body: ListView(padding: EdgeInsets.only(top: 4), children: [
        profileTile(
            margin: 8,
            iconsize: 35,
            isthreelines: true,
            leadingWidget: Container(
              decoration: boxDecoration(
                radius: 9,
                color: Mycolors.orange,
                showShadow: false,
                bgColor: Mycolors.orange,
              ),
              height: 40,
              width: 40,
              child: Center(
                child: Icon(
                  Icons.app_settings_alt,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            title: 'User app Settings',
            subtitle: 'Settings that are controlled through database',
            leadingicondata: Icons.settings_applications_rounded,
            leadingiconcolor: Mycolors.red,
            ontap: () {
              pageNavigator(
                  context,
                  UserAppSettings(
                    pagetype: Dbkeys.userapp,
                  ));
            }),
        profileTile(
            margin: 8,
            iconsize: 35,
            isthreelines: true,
            leadingWidget: Container(
              decoration: boxDecoration(
                radius: 9,
                color: Mycolors.red,
                showShadow: false,
                bgColor: Mycolors.red,
              ),
              height: 40,
              width: 40,
              child: Center(
                child: Icon(
                  Icons.data_usage_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            title: 'Usage Controls',
            subtitle: 'Settings that are controlled through database',
            ontap: () {
              pageNavigator(
                  context,
                  UserAppSettings(
                    pagetype: 'controls',
                  ));
              // pageNavigator(context, InitialSetup());
            },
            leadingicondata: Icons.settings_applications_rounded),
        profileTile(
            margin: 8,
            iconsize: 35,
            isthreelines: true,
            leadingWidget: Container(
              decoration: boxDecoration(
                radius: 9,
                color: Mycolors.blue,
                showShadow: false,
                bgColor: Mycolors.blue,
              ),
              height: 40,
              width: 40,
              child: Center(
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            title: 'Terms & Privacy policy',
            subtitle: 'Basic Info of the Company/Brand for Contact Us page.',
            leadingicondata: Icons.settings_applications_rounded,
            ontap: () {
              // pageNavigator(context, InitialSetup());
              pageNavigator(
                  context,
                  UserAppSettings(
                    pagetype: Dbkeys.tnc,
                  ));
            }),
        SizedBox(
          height: 30,
        ),
        profileTile(
            margin: 8,
            iconsize: 35,
            isthreelines: true,
            leadingWidget: Container(
              decoration: boxDecoration(
                radius: 9,
                color: Mycolors.green,
                showShadow: false,
                bgColor: Mycolors.green,
              ),
              height: 40,
              width: 40,
              child: Center(
                child: Icon(
                  Icons.app_settings_alt,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            title: 'Admin app Settings',
            subtitle: 'Settings that are controlled through database',
            leadingicondata: Icons.settings_applications_rounded,
            leadingiconcolor: Mycolors.red,
            ontap: () {
              pageNavigator(
                  context,
                  AdminAppSettings(
                    pagetype: Dbkeys.adminapp,
                  ));
            }),
      ]),
    );
  }
}
