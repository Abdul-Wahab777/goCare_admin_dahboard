import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:thinkcreative_technologies/Screens/authentication/ChangeLoginCredentials.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Screens/initialization/adminapp.dart';
import 'package:thinkcreative_technologies/Screens/networkSensitiveUi/NetworkSensitiveUi.dart';
import 'package:thinkcreative_technologies/Services/providers/BottomNavBar.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:thinkcreative_technologies/Widgets/MyInkWell.dart';
import 'package:thinkcreative_technologies/Widgets/MySharedPrefs.dart';
import 'package:thinkcreative_technologies/Widgets/avatars/customCircleAvatars.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';

class AdminAccount extends StatefulWidget {
  @override
  _AdminAccountState createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  var top = 0.0;

  @override
  void initState() {
    super.initState();
  }

  unsubscribeFromNotifications() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(Dbkeys.topicADMIN);
  }

  late FirebaseAuth _auth;
  signOutAnonymousAccount() async {
    _auth = FirebaseAuth.instance;
    await _auth.signOut();
  }

  Future<void> _signOut(BuildContext context) async {
    final observer = Provider.of<Observer>(context, listen: false);
    try {
      await signOutAnonymousAccount().then((value) {
        MySharedPrefs().setmybool('isLoggedIn', false);
        unsubscribeFromNotifications();
      }).then((value) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AdminApp(
                      doc: observer.adminAppSettings!,
                    )));
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double w = size.width;

    return NetworkSensitive(
      child: Utils.getNTPWrappedWidget(Consumer<CommonSession>(
          builder: (context, session, _child) => Consumer<Observer>(
              builder: (context, observer, _child) => Consumer<
                      BottomNavigationBarProvider>(
                  builder: (context, provider, _child) => Scaffold(
                        // resizeToAvoidBottomPadding: true,
                        key: _scaffoldKey,

                        backgroundColor: Colors.white,
                        body: CustomScrollView(
                          controller: _scrollController,
                          slivers: <Widget>[
                            SliverAppBar(
                              backgroundColor: Mycolors.primary,
                              elevation: 1.0,
                              expandedHeight: 173,
                              pinned: true,
                              floating: false,
                              title: MtCustomfontBold(
                                  color: Colors.white,
                                  text: 'Account',
                                  fontsize: 20),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: IconButton(
                                      icon: const Icon(LineAwesomeIcons.bell,
                                          size: 24),
                                      color: Mycolors.white,
                                      onPressed: () {
                                        provider.setcurrentIndex(3);
                                      }),
                                ),
                              ],
                              flexibleSpace: LayoutBuilder(builder:
                                  (BuildContext context,
                                      BoxConstraints constraints) {
                                var top = constraints.biggest.height;
                                // print('TOP:::$top');
                                int triggerheight = 130;
                                return FlexibleSpaceBar(
                                  collapseMode: CollapseMode.parallax,
                                  title: AnimatedOpacity(
                                    opacity: top > 95 && top < 133 ? 0 : 0.99,
                                    duration: Duration(milliseconds: 20),
                                    //opacity: top > 71 && top < 91 ? 1.0 : 0.0,
                                    child: Container(
                                        height:
                                            top > 0 && top < triggerheight - 15
                                                ? 20
                                                : 50,
                                        // width: w / 2,
                                        margin: EdgeInsets.only(
                                            left: top > 0 &&
                                                    top < triggerheight - 32
                                                ? 0
                                                : 27),
                                        child: top > 0 &&
                                                top < triggerheight - 15
                                            ? MtCustomfontBold(
                                                maxlines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontsize: top > 0 &&
                                                        top < triggerheight - 6
                                                    ? 19
                                                    : 17,
                                                color: Colors.black,
                                                text: '',
                                              )
                                            : SizedBox()),
                                  ),
                                  background: Container(
                                    color: Mycolors.primary,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      // fit: StackFit.expand,
                                      // overflow: Overflow.visible,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                alignment: Alignment.bottomLeft,
                                                width: 80,
                                                child: customCircleAvatar(
                                                    url: session.photourl,
                                                    radius: 35)),
                                            Container(
                                              // color: Mycolors.red,
                                              margin: EdgeInsets.only(left: 15),
                                              alignment: Alignment.topLeft,
                                              width: w - 125,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MtCustomfontBoldSemi(
                                                    text: session.fullname,
                                                    color: Colors.white,
                                                    maxlines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    lineheight: 1.2,
                                                    fontsize: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  MtCustomfontRegular(
                                                    text: 'Admin account',
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                    maxlines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    lineheight: 1.2,
                                                    fontsize: 14,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                <Widget>[
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  eachsimpletile(
                                      ontap: AppConstants.isdemomode == true
                                          ? () {
                                              Utils.toast(
                                                  'Not Allowed in Demo App');
                                            }
                                          : () {
                                              pageNavigator(
                                                  context,
                                                  ChangeLoginCredentials(
                                                    isFirstTime: false,
                                                  ));
                                            },
                                      context: context,
                                      title: 'Edit Profile',
                                      icondata: LineAwesomeIcons.edit),
                                  eachsimpletile(
                                      ontap: () {
                                        String? applink = Platform.isAndroid
                                            ? session.adminSettings[
                                                Dbkeys.newapplinkandroid]
                                            : Platform.isIOS
                                                ? session.adminSettings[
                                                    Dbkeys.newapplinkios]
                                                : session.adminSettings[
                                                    Dbkeys.newapplinkweb];
                                        HapticFeedback.vibrate();
                                        Share.share(
                                            'Hello! I am sharing with you the ${AppConstants.appname} app. \n\nDownload app from this link:\n$applink');
                                      },
                                      context: context,
                                      title: 'Share app',
                                      icondata: LineAwesomeIcons.share),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        8,
                                        MediaQuery.of(context).size.height /
                                            3.6,
                                        8,
                                        8),
                                    child: MySimpleButton(
                                      onpressed: () async {
                                        await _signOut(context);
                                      },
                                      buttontext: 'LOGOUT',
                                      buttoncolor: Colors.red[600],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(35),
                                    child: MtCustomfontMedium(
                                        color: Mycolors.grey.withOpacity(0.7),
                                        textalign: TextAlign.center,
                                        fontsize: 13.7,
                                        text: 'App Version: ' +
                                            AppConstants.appcurrentversion),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))))),
    );
  }

  // _renderSelectedMedia(BuildContext context, Product product, Size size) {
  //   /// Render selected video
  //   if (selectedUrl != null && isVideoSelected) {
  //     return FeatureVideoPlayer(
  //       url: selectedUrl.replaceAll("http://", "https://"),
  //       autoPlay: true,
  //     );
  //   }

  /// Render selected image
  // if (selectedUrl != null && !isVideoSelected) {
  //   return GestureDetector(
  //     onTap: () {
  //       showDialog<void>(
  //         context: context,
  //         builder: (BuildContext context) {
  //           final images = [...product.images];
  //           final int index = product.images.indexOf(selectedUrl);
  //           if (index == -1) {
  //             images.insert(0, selectedUrl);
  //           }
  //           return ImageGalery(
  //             images: images,
  //             index: index == -1 ? 0 : index,
  //           );
  //         },
  //       );
  //     },
  //     child: Tools.image(
  //       url: selectedUrl,
  //       fit: BoxFit.contain,
  //       width: size.width,
  //       size: kSize.large,
  //       hidePlaceHolder: true,
  //     ),
  //   );
  // }

  /// Render default feature image
  //   return product.type == 'variable'
  //       ? VariantImageFeature(product)
  //       : ImageFeature(product);
  // }
}

eachsimpletile({
  BuildContext? context,
  String? title,
  Function? ontap,
  Widget? iconwidget,
  IconData? icondata,
  double? iconsize,
  double? textfontsize,
  Color? iconcolor,
  Color? tilecolor,
  Color? textcolor,
  bool? isshowtrailing,
}) {
  return myinkwell(
    onTap: ontap ?? null,
    child: Container(
      padding: EdgeInsets.fromLTRB(19, 19, 14, 18),
      decoration: BoxDecoration(
        color: tilecolor ?? Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Mycolors.greylightcolor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                iconwidget ??
                    Icon(
                      icondata ?? Icons.emoji_emotions_sharp,
                      size: iconsize ?? 26,
                      color: iconcolor ?? Mycolors.primary,
                    ),
                SizedBox(
                  width: 19,
                ),
                MtCustomfontMedium(
                  text: title ?? 'My Orders',
                  fontsize: textfontsize ?? 15.0,
                  color: textcolor ?? Mycolors.black.withOpacity(0.89),
                ),
              ],
            ),
          ),
          isshowtrailing == null || isshowtrailing == true
              ? Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 22,
                  color: Mycolors.primary.withOpacity(0.8),
                )
              : SizedBox(width: 0),
        ],
      ),
    ),
  );
}
