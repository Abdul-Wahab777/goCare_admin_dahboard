import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Models/CountrydataList.dart';
import 'package:thinkcreative_technologies/Screens/callHistory/callHistory.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';
import 'package:thinkcreative_technologies/Screens/networkSensitiveUi/NetworkSensitiveUi.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseUploader.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:thinkcreative_technologies/Widgets/DelayedFunction.dart';
import 'package:thinkcreative_technologies/Widgets/MyInkWell.dart';
import 'package:thinkcreative_technologies/Widgets/TimeFormatterMyTimeZone.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/myVerticaldivider.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreCOLLECTIONDataProvider.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';
import 'package:thinkcreative_technologies/Widgets/tiles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDetails extends StatefulWidget {
  final String? userProfileUid;
  final doc;
  final String? pagecollectiontype;
  final String? pagekeyword;
  final bool isProfileFetchedFromProvider;
  ProfileDetails(
      {this.userProfileUid,
      this.pagecollectiontype,
      this.pagekeyword,
      required this.isProfileFetchedFromProvider,
      this.doc});
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _controller = new TextEditingController();
  var userDoc;

  @override
  void initState() {
    super.initState();
    if (widget.doc != null) {
      setState(() {
        userDoc = widget.doc;
      });
    } else {}
  }

  _launchCaller(String? telnumber) async {
    // String url = "tel:$telnumber";
    // custom_url_launcher(url);
    final Uri params = Uri(scheme: 'tel', path: telnumber!);
    launchUrl(params, mode: LaunchMode.platformDefault);
  }

  confirmchangeswitch(
    BuildContext context,
    String? accountSTATUS,
    String? userid,
    String? fullname,
    String? photourl,
  ) async {
    final user = Provider.of<CommonSession>(context, listen: false);
    final firestore =
        Provider.of<FirestoreDataProviderUSERS>(context, listen: false);
    final observer = Provider.of<Observer>(context, listen: false);
    ShowSnackbar().close(context: context, scaffoldKey: _scaffoldKey);
    await ShowConfirmWithInputTextDialog().open(
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
        rightbtnonpress:
            //  ((accountSTATUS == Dbkeys.sTATUSallowed) &&
            //             (_controller.text.trim().length > 100 ||
            //                 _controller.text.trim().length < 1)) ==
            //         true
            //     ? () {}
            //     :
            () async {
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
                      : widget.pagecollectiontype == DbPaths.collectionpartners
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
                      : widget.pagecollectiontype == DbPaths.collectionpartners
                          ? (accountSTATUS == Dbkeys.sTATUSallowed
                              ? Dbkeys.totalapprovedpartners
                              : accountSTATUS == Dbkeys.sTATUSblocked
                                  ? Dbkeys.totalblockedpartners
                                  : Dbkeys.totalpendingpartners)
                          : null,
            )
                .then((value) async {
              await FirebaseApi().runUPDATEtransactionNotification(
                  refdata: FirebaseFirestore.instance
                      .collection(widget.pagecollectiontype!)
                      .doc(userid)
                      .collection(DbPaths.collectionnotifications)
                      .doc(DbPaths.collectionnotifications),
                  isshowmsg: false,
                  context: context,
                  scaffoldkey: _scaffoldKey,
                  isusesecondfn: false,
                  isshowloader: false,
                  // keyloader: _keyLoader3,
                  totaldeleterange: 200,
                  totallimitfordelete: 400,
                  newmapnotificationcontent: {
                    Dbkeys.docid: DateTime.now().millisecondsSinceEpoch,
                    Dbkeys.nOTIFICATIONxxdesc: accountSTATUS ==
                            Dbkeys.sTATUSallowed
                        ? _controller.text.trim().length < 1
                            ? 'Your account is Blocked. Reason not mentioned.'
                            : 'Your account is Blocked for the Reason: ${_controller.text.trim()}.'
                        : accountSTATUS == Dbkeys.sTATUSpending
                            ? 'Congratulations! Your account is Approved. you can now start using the app.'
                            : accountSTATUS == Dbkeys.sTATUSblocked
                                ? 'Congratulations! Block from your account is removed. You can now start using the app'
                                : 'Your account status is changed',
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
                        user.uid + 'XXX' + AppConstants.apptype,
                  },
                  newmapnotification: {
                    Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionPUSH,
                    Dbkeys.nOTIFICATIONxxdesc: accountSTATUS ==
                            Dbkeys.sTATUSallowed
                        ? _controller.text.trim().length < 1
                            ? 'Your account is Blocked. Reason not mentioned.'
                            : 'Your account is Blocked for the Reason: ${_controller.text.trim()}.'
                        : accountSTATUS == Dbkeys.sTATUSpending
                            ? 'Congratulations! Your account is Approved. you can now start using the app.'
                            : accountSTATUS == Dbkeys.sTATUSblocked
                                ? 'Congratulations! Block from your account is removed. You can now start using the app'
                                : 'Your account status is changed',
                    Dbkeys.nOTIFICATIONxxtitle:
                        accountSTATUS == Dbkeys.sTATUSallowed
                            ? 'Account BLOCKED'
                            : accountSTATUS == Dbkeys.sTATUSpending
                                ? 'Account APPROVED'
                                : accountSTATUS == Dbkeys.sTATUSblocked
                                    ? 'Account APPROVED'
                                    : 'Account Status changed',
                    Dbkeys.nOTIFICATIONxxpageID: Dbkeys.pageIDAllNotifications,
                    Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
                    Dbkeys.nOTIFICATIONxxparentid: userid,
                    Dbkeys.nOTIFICATIONxxpagecompareval: userid,
                    Dbkeys.nOTIFICATIONxxauthor:
                        user.uid + 'XXX' + AppConstants.apptype,
                  }).then((value) async {
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
                            ? '$fullname (${widget.pagekeyword}) account is Blocked for the Reason: ${_controller.text.trim()}. By- ${user.fullname} from ${AppConstants.apptype} '
                            : accountSTATUS == Dbkeys.sTATUSpending
                                ? '$fullname (${widget.pagekeyword}) account is Approved. By- ${user.fullname} from ${AppConstants.apptype} '
                                : accountSTATUS == Dbkeys.sTATUSblocked
                                    ? '$fullname (${widget.pagekeyword}) account Block is removed. By- ${user.fullname} from ${AppConstants.apptype} '
                                    : '$fullname (${widget.pagekeyword}) account status is changed. By- ${user.fullname} from ${AppConstants.apptype} ',
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
                            user.uid + 'XXX' + AppConstants.apptype,
                        Dbkeys.nOTIFICATIONxxextrafield: userid,
                      });
                }
              }).then((value) async {
                if (widget.isProfileFetchedFromProvider == true) {
                  await firestore.updateparticulardocinProvider(
                      context: context,
                      scaffoldkey: _scaffoldKey,
                      compareKey: Dbkeys.uSERphone,
                      compareVal: userid,
                      collection: widget.pagecollectiontype!,
                      document: userid);
                }
                await FirebaseFirestore.instance
                    .collection(widget.pagecollectiontype!)
                    .doc(userid)
                    .get()
                    .then((user) {
                  setState(() {
                    userDoc = user.data();
                  });
                });
              }).then((value) async {
                await ShowLoading().close(context: context, key: _keyLoader);
                _controller.clear();

                ShowSnackbar().open(
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    status: 2,
                    time: 3,
                    label: accountSTATUS == Dbkeys.sTATUSallowed
                        ? 'Success !  ${fullname!.toUpperCase()} is Blocked. ${widget.pagekeyword} will be notified automatically.'
                        : accountSTATUS == Dbkeys.sTATUSblocked
                            ? 'Success !  ${fullname!.toUpperCase()} is Allowed. ${widget.pagekeyword} will be notified automatically.'
                            : 'Success !  ${fullname!.toUpperCase()} is Approved & Allowed. ${widget.pagekeyword} will be notified automatically.');
              });
            });
          }).catchError((error) {
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
        });
  }

  Widget ratingbar({double? rate}) {
    return RatingBarIndicator(
      rating: rate ?? 1.15,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 15.0,
      direction: Axis.horizontal,
    );
  }

  setAsOffline(BuildContext context) async {
    final firestore =
        Provider.of<FirestoreDataProviderUSERS>(context, listen: false);
    Utils.toast('Please wait !');
    await FirebaseFirestore.instance
        .collection(widget.pagecollectiontype!)
        .doc(userDoc[Dbkeys.uSERphone])
        .update({
      Dbkeys.uSERlastseen: DateTime.now().millisecondsSinceEpoch,
    });
    if (widget.isProfileFetchedFromProvider == true) {
      await firestore.updateparticulardocinProvider(
          context: context,
          scaffoldkey: _scaffoldKey,
          compareKey: Dbkeys.uSERphone,
          compareVal: userDoc[Dbkeys.uSERphone],
          collection: widget.pagecollectiontype!,
          document: userDoc[Dbkeys.uSERphone]);
    }
    await FirebaseFirestore.instance
        .collection(widget.pagecollectiontype!)
        .doc(userDoc[Dbkeys.uSERphone])
        .get()
        .then((user) {
      setState(() {
        userDoc = user.data();
      });
    });
  }

  Widget buildheader() {
    int flagIndex = countryData.indexWhere((element) =>
        element.split('---')[0] == userDoc[Dbkeys.uSERcountrycode]);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(12, 12, 12.0, 7.0),
                  padding: EdgeInsets.only(bottom: 10),
                  width: 85,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Mycolors.greylightcolor,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: userDoc[Dbkeys.uSERaccountstatus] ==
                              Dbkeys.sTATUSblocked
                          ? NetworkImage(
                              AppConstants.defaultprofilepicfromnetworklink)
                          : NetworkImage(userDoc[Dbkeys.uSERphotourl] == null ||
                                  userDoc[Dbkeys.uSERphotourl] == ''
                              ? AppConstants.defaultprofilepicfromnetworklink
                              : userDoc[Dbkeys.uSERphotourl]),
                    ),
                  ),
                ),
                userDoc[Dbkeys.uSERlastseen] == true
                    ? Positioned(
                        bottom: 10,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                            decoration:
                                boxDecoration(radius: 10, showShadow: false),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 3),
                                MtCustomfontMedium(
                                  text: 'Online',
                                  fontsize: 12,
                                )
                              ],
                            )))
                    : SizedBox(),
              ],
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.6,
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MtCustomfontBold(
                color: Mycolors.white,
                text: userDoc[Dbkeys.uSERfullname] ?? '',
                fontsize: 19.5,
              ),

              Divider(
                color: Colors.white10,
              ),

              SizedBox(
                height: 5.0,
              ),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Icon(Icons.timer, color: Colors.white, size: 15),
              //     SizedBox(width: 10),
              //     MtCustomfontRegular(
              //       text: 'Lastseen 12 years ago ',
              //       color: Mycolors.whitelight,
              //       fontsize: 13,
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone, color: Colors.white, size: 15),
                  SizedBox(width: 10),
                  MtCustomfontRegular(
                    text: AppConstants.isdemomode == true
                        ? '${userDoc[Dbkeys.uSERphone].substring(0, 6)}********'
                        : '${userDoc[Dbkeys.uSERphone]}',
                    color: Mycolors.whitelight,
                    fontsize: 13,
                  ),
                ],
              ),
              SizedBox(
                height: 11.0,
              ),
              userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                  ? SizedBox()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 15),
                        SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: MtCustomfontRegular(
                            text:
                                '${countryData[flagIndex].split('---')[3]}  ${countryData[flagIndex].split('---')[1]}  ',
                            color: Mycolors.whitelight,
                            maxlines: 2,
                            lineheight: 1.3,
                            overflow: TextOverflow.ellipsis,
                            fontsize: 13,
                          ),
                        ),
                      ],
                    ),
              // Text(
              //   'about 12 hours ago',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //       fontSize: 11.0,
              //       color: Mycolors.grey,
              //       fontFamily: "WorkSansSemiBold",
              //       fontWeight: FontWeight.w500),
              // ),

              SizedBox(
                height: 13,
              ),

              SizedBox(
                height: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>(debugLabel: '0000');

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return NetworkSensitive(
      child: Utils.getNTPWrappedWidget(Consumer<Observer>(
          builder: (context, observer, _child) => Consumer<CommonSession>(
              builder: (context, user, _child) => MyScaffold(
                  iconTextColor: Mycolors.white,
                  appbarColor: Mycolors.primary,
                  elevation: 0,
                  icondata1: userDoc[Dbkeys.uSERemail] == null ||
                          userDoc[Dbkeys.uSERemail] == ''
                      ? null
                      : Icons.email_outlined,
                  icondata2: userDoc[Dbkeys.uSERphone] == null ||
                          userDoc[Dbkeys.uSERphone] == ''
                      ? null
                      : Icons.call,
                  icon2press: AppConstants.isdemomode == true
                      ? () {
                          Utils.toast('Not Allowed in Demo App');
                        }
                      : () {
                          _launchCaller(userDoc[Dbkeys.uSERphone]);
                        },
                  scaffoldkey: _scaffoldKey,
                  title: '${widget.pagekeyword} Profile',
                  // appBar: AppBar(
                  //   elevation: 0,
                  //   titleSpacing: 0,
                  //   title: MtCustomfontBold(
                  //     color: Mycolors.white,
                  //     text: 'Profile',
                  //   ),
                  //   backgroundColor: Mycolors.primary,
                  // ),
                  body: ListView(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(children: [
                            Container(
                              height: 220,
                              color: Mycolors.primary,
                              child: Row(children: [buildheader()]),
                            ),
                            Container(
                              height: 110,
                              color: Colors.transparent,
                            ),
                          ]),
                          Positioned(
                            bottom: 0,
                            child: userDoc[Dbkeys.uSERaccountstatus] ==
                                    Dbkeys.sTATUSdeleted
                                ? SizedBox()
                                : Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(2),
                                    child: GridView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        eachGridTile(
                                            label: 'Audio Call Made',
                                            width: w / 1.0,
                                            icon: MtPoppinsBold(
                                              lineheight: 0.8,
                                              text:
                                                  '${userDoc[Dbkeys.audiocallsmade]}',
                                              color: Mycolors.grey,
                                              // fontsize: 12,
                                              
                                            )),
                                        eachGridTile(
                                            label: 'Audio Call Recieved',
                                            width: w / 1.0,
                                            icon: MtPoppinsBold(
                                              lineheight: 0.8,
                                              text:
                                                  '${userDoc[Dbkeys.audioCallRecieved]}',
                                              color: Mycolors.grey,
                                              // fontsize: 22,
                                            )),
                                        eachGridTile(
                                            label: 'Video Call Made',
                                            width: w / 1.0,
                                            icon: MtPoppinsBold(
                                              lineheight: 0.8,
                                              text:
                                                  '${userDoc[Dbkeys.audiocallsmade]}',
                                              color: Mycolors.grey,
                                              // fontsize: 22,
                                            )),
                                        eachGridTile(
                                            label: 'Video Call Recieved',
                                            width: w / 1.0,
                                            icon: MtPoppinsBold(
                                              lineheight: 0.8,
                                              text:
                                                  '${userDoc[Dbkeys.videoCallRecieved]}',
                                              color: Mycolors.grey,
                                              // fontsize: 22,
                                            )),
                                        eachGridTile(
                                            label: 'Media Sent',
                                            width: w / 1.0,
                                            icon: MtPoppinsBold(
                                              lineheight: 0.8,
                                              text:
                                                  '${userDoc[Dbkeys.mssgSent]}',
                                              color: Mycolors.grey,
                                              // fontsize: 22,
                                            )),
                                        eachGridTile(
                                            label: 'App Visits',
                                            width: w / 1.0,
                                            icon: MtPoppinsBold(
                                              lineheight: 0.8,
                                              text: userDoc.containsKey(Dbkeys
                                                          .totalvisitsANDROID) &&
                                                      userDoc.containsKey(
                                                          Dbkeys.totalvisitsIOS)
                                                  ? '${userDoc[Dbkeys.totalvisitsANDROID] + userDoc[Dbkeys.totalvisitsIOS]}'
                                                  : userDoc.containsKey(Dbkeys
                                                              .totalvisitsANDROID) &&
                                                          !userDoc.containsKey(
                                                              Dbkeys
                                                                  .totalvisitsIOS)
                                                      ? '${userDoc[Dbkeys.totalvisitsANDROID]}'
                                                      : !userDoc.containsKey(Dbkeys
                                                                  .totalvisitsANDROID) &&
                                                              userDoc.containsKey(
                                                                  Dbkeys
                                                                      .totalvisitsIOS)
                                                          ? '${userDoc[Dbkeys.totalvisitsIOS]}'
                                                          : '0',
                                              color: Mycolors.grey,
                                              // fontsize: 22,
                                            )),
                                      ],
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 1.35,
                                              mainAxisSpacing: 4,
                                              crossAxisSpacing: 4),
                                      padding: EdgeInsets.all(2),
                                    ),
                                    decoration: boxDecoration(showShadow: true,    
                                                                
),
                                    // height: 170,
                                    width: w / 1.1,
                                  ),
                            //  Container(
                            //   child: Column(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceAround,
                            //           children: [
                            //             eachcount(
                            //                 text: 'Audio Call Made',
                            //                 count:
                            //                     '${userDoc[Dbkeys.audiocallsmade]}'),
                            //             myverticaldivider(
                            //                 height: 50,
                            //                 color: Mycolors.greylightcolor),
                            //             eachcount(text: 'Video Calls'),
                            //             myverticaldivider(
                            //                 height: 50,
                            //                 color: Mycolors.greylightcolor),
                            //             eachcount(text: 'Media Sent'),
                            //           ]),
                            //       myvhorizontaldivider(width: w / 1.2),
                            //       Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceAround,
                            //           children: [
                            //             eachcount(
                            //                 text: 'Audio Calls',
                            //                 count:
                            //                     '${userDoc[Dbkeys.audiocallsmade]}'),
                            //             myverticaldivider(
                            //                 height: 50,
                            //                 color: Mycolors.greylightcolor),
                            //             eachcount(text: 'Video Calls'),
                            //             myverticaldivider(
                            //                 height: 50,
                            //                 color: Mycolors.greylightcolor),
                            //             eachcount(text: 'Media Sent'),
                            //           ]),
                            //     ],
                            //   ),

                            // )
                          ),
                        ],
                      ),
                      userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    MtCustomfontBold(
                                      text: "ACCOUNT DELETED",
                                      color: Mycolors.red,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MtCustomfontLight(
                                      text: userDoc[Dbkeys.uSERactionmessage],
                                      color: Mycolors.red,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : InputSwitch(
                              onString: userDoc[Dbkeys.uSERaccountstatus] ==
                                      Dbkeys.sTATUSallowed
                                  ? ' STATUS:  Approved'
                                  : userDoc[Dbkeys.uSERaccountstatus] ==
                                          Dbkeys.sTATUSblocked
                                      ? ' STATUS:  Blocked'
                                      : userDoc[Dbkeys.uSERaccountstatus] ==
                                              Dbkeys.sTATUSallowed
                                          ? ' STATUS:  Pending Approval'
                                          : '',
                              offString: userDoc[Dbkeys.uSERaccountstatus] ==
                                      Dbkeys.sTATUSallowed
                                  ? ' STATUS:  Approved'
                                  : userDoc[Dbkeys.uSERaccountstatus] ==
                                          Dbkeys.sTATUSblocked
                                      ? ' STATUS:  Blocked'
                                      : userDoc[Dbkeys.uSERaccountstatus] ==
                                              Dbkeys.sTATUSallowed
                                          ? ' STATUS:  Pending Approval'
                                          : 'STATUS:',
                              initialbool: userDoc[Dbkeys.uSERaccountstatus] ==
                                      Dbkeys.sTATUSallowed
                                  ? true
                                  : userDoc[Dbkeys.uSERaccountstatus] ==
                                          Dbkeys.sTATUSblocked
                                      ? false
                                      : userDoc[Dbkeys.uSERaccountstatus] ==
                                              Dbkeys.sTATUSpending
                                          ? false
                                          : false,
                              onChanged: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                        context,
                                        userDoc[Dbkeys.uSERaccountstatus],
                                        userDoc[Dbkeys.uSERphone],
                                        userDoc[Dbkeys.uSERfullname],
                                        userDoc[Dbkeys.uSERphotourl],
                                      );
                                    },
                            ),

                      userDoc[Dbkeys.uSERaccountstatus] ==
                                  Dbkeys.sTATUSblocked ||
                              userDoc[Dbkeys.uSERaccountstatus] ==
                                  Dbkeys.sTATUSpending
                          ? Container(
                              decoration: boxDecoration(
                                  radius: 7,
                                  color: Mycolors.orange,
                                  bgColor: Mycolors.orange.withOpacity(0.2)),
                              width: w,
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  MtCustomfontBoldSemi(
                                    textalign: TextAlign.left,
                                    text: 'User alert message :',
                                    fontsize: 14,
                                    color: Colors.orange[800],
                                  ),
                                  Divider(),
                                  MtCustomfontBoldSemi(
                                      textalign: TextAlign.left,
                                      text: userDoc[Dbkeys.uSERactionmessage] ==
                                                  null ||
                                              userDoc[Dbkeys
                                                      .uSERactionmessage] ==
                                                  ''
                                          ? ''
                                          : userDoc[Dbkeys.uSERactionmessage],
                                      fontsize: 14,
                                      color: Mycolors.black,
                                      lineheight: 1.3)
                                ],
                              ),
                            )
                          : SizedBox(),

                      // Container(
                      //   color: Colors.white,
                      //   child: ListTile(
                      //     title: MtCustomfontMedium(
                      //       fontsize: 16,
                      //       color: Mycolors.black,
                      //       text: 'Send Notification',
                      //     ),

                      //     subtitle: MtCustomfontRegular(
                      //       text: 'Send Notification to this User Only',
                      //       fontsize: 13,
                      //     ),
                      //     trailing: Icon(Icons.keyboard_arrow_right),
                      //     leading: Icon(
                      //       EvaIcons.paperPlane,
                      //       color: Mycolors.primary,
                      //     ),
                      //     // isThreeLine: true,
                      //     onTap: () async {
                      //       await createNotificationID(
                      //           context, RandomDigits.getString(8));
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                          ? SizedBox()
                          : Container(
                              color: Colors.white,
                              child: ListTile(
                                title: MtCustomfontMedium(
                                  fontsize: 16,
                                  color: Mycolors.black,
                                  text: 'Call History',
                                ),

                                subtitle: MtCustomfontRegular(
                                  text: 'See User Call Log',
                                  fontsize: 13,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                leading: Icon(
                                  EvaIcons.phoneCallOutline,
                                  color: Mycolors.primary,
                                ),
                                // isThreeLine: true,
                                onTap: () async {
                                  pageNavigator(
                                      context,
                                      CallHistory(
                                        userphone: userDoc[Dbkeys.uSERphone],
                                        fullname: userDoc[Dbkeys.uSERfullname],
                                      ));
                                },
                              ),
                            ),
                      SizedBox(
                        height: 19,
                      ),

                      userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                          ? SizedBox()
                          : Container(
                              color: Colors.white,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: MtCustomfontBoldSemi(
                                    color: Mycolors.black,
                                    text: 'Last Seen',
                                    fontsize: 15.6,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: MtCustomfontRegular(
                                    color: Mycolors.grey,
                                    text: userDoc[Dbkeys.uSERlastseen] == true
                                        ? 'Online'
                                        : userDoc[Dbkeys.uSERlastseen] !=
                                                    null &&
                                                userDoc[Dbkeys.uSERlastseen] !=
                                                    true
                                            ? formatTimeDateCOMLPETEString(
                                                isdateTime: true,
                                                isshowutc: false,
                                                context: context,
                                                datetimetargetTime: DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        userDoc[Dbkeys
                                                            .uSERlastseen]))
                                            : 'Not Available',
                                    fontsize: 12.8,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.access_time_rounded,
                                  color: Mycolors.primary,
                                ),
                                trailing: userDoc[Dbkeys.uSERlastseen] == true
                                    ? myinkwell(
                                        onTap: AppConstants.isdemomode == true
                                            ? () {
                                                Utils.toast(
                                                    'Not Allowed in Demo App');
                                              }
                                            : () {
                                                setAsOffline(context);
                                              },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MtCustomfontBold(
                                            text: 'SET AS OFFLINE',
                                            fontsize: 12.6,
                                            color: Mycolors.primary,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                isThreeLine: false,
                                onTap: () {},
                              )),
                      SizedBox(
                        height: 10,
                      ),
                      userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                          ? SizedBox()
                          : Container(
                              color: Colors.white,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: MtCustomfontBoldSemi(
                                    color: Mycolors.black,
                                    text: 'Joined On',
                                    fontsize: 15.6,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: MtCustomfontRegular(
                                    color: Mycolors.grey,
                                    text: formatTimeDateCOMLPETEString(
                                        isdateTime: true,
                                        isshowutc: false,
                                        context: context,
                                        datetimetargetTime:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                userDoc[Dbkeys.uSERjoinedon])),
                                    fontsize: 12.8,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.access_time_rounded,
                                  color: Mycolors.primary,
                                ),
                                isThreeLine: false,
                                onTap: () {},
                              )),
                      SizedBox(
                        height: 18,
                      ),
                      userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                          ? SizedBox()
                          : userDoc[Dbkeys.uSERdevicelist] == null ||
                                  userDoc[Dbkeys.uSERdevicelist].isEmpty
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                                  decoration: boxDecoration(showShadow: true),
                                  child: Column(children: [
                                    MtCustomfontMedium(
                                      text: 'User Device information',
                                      color: Mycolors.primary,
                                      fontsize: 15,
                                    ),
                                    myvhorizontaldivider(
                                        width: w, marginheight: 14),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.phone_iphone,
                                                color: Mycolors.secondary,
                                                size: 22,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              MtCustomfontRegular(
                                                text: userDoc[
                                                        Dbkeys
                                                            .uSERdevicelist][Dbkeys
                                                        .deviceInfoMANUFACTURER] +
                                                    ' ' +
                                                    userDoc[Dbkeys
                                                            .uSERdevicelist][
                                                        Dbkeys.deviceInfoMODEL],
                                                color: Mycolors.grey,
                                                fontsize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        userDoc[Dbkeys.uSERdevicelist]
                                                    [Dbkeys.deviceInfoOS] ==
                                                'android'
                                            ? Icon(
                                                Icons.android,
                                                color: Color(0xFFA0C034),
                                              )
                                            : Image.asset(
                                                'assets/COMMON_ASSETS/apple.png',
                                                height: 20,
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Mycolors.secondary,
                                                size: 22,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              MtCustomfontRegular(
                                                text: 'Physical Real Device',
                                                color: Mycolors.grey,
                                                fontsize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    userDoc[Dbkeys.uSERaccountstatus] ==
                                            Dbkeys.sTATUSdeleted
                                        ? SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      color: Mycolors.secondary,
                                                      size: 21,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    MtCustomfontRegular(
                                                      text: 'Last login: ' +
                                                          formatTimeDateCOMLPETEString(
                                                              context: context,
                                                              isdateTime: false,
                                                              timestamptargetTime:
                                                                  userDoc[Dbkeys
                                                                          .uSERdevicelist]
                                                                      [Dbkeys
                                                                          .deviceInfoLOGINTIMESTAMP]),
                                                      color: Mycolors.grey,
                                                      fontsize: 14,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ]),
                                ),
                      SizedBox(
                        height: 10,
                      ),
                      userDoc[Dbkeys.uSERaccountstatus] == Dbkeys.sTATUSdeleted
                          ? SizedBox()
                          : userDoc[Dbkeys.uSERaccountstatus] ==
                                  Dbkeys.sTATUSdeleted
                              ? SizedBox()
                              : Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: MtCustomfontMedium(
                                      fontsize: 16,
                                      color: Mycolors.black,
                                      text: 'Firebase UID',
                                    ),

                                    subtitle: MtCustomfontRegular(
                                      text: AppConstants.isdemomode == true
                                          ? 'gysdur573wr573r782***********'
                                          : userDoc['id'] ?? '',
                                      fontsize: 13,
                                    ),
                                    trailing: Icon(Icons.copy_outlined),
                                    leading: Icon(
                                      EvaIcons.personDoneOutline,
                                      color: Mycolors.primary,
                                    ),
                                    // isThreeLine: true,
                                    onTap: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            Clipboard.setData(new ClipboardData(
                                                text: userDoc['id'] ?? ''));
                                            Utils.toast('Copied to Clipboard');
                                          },
                                  ),
                                ),
                      SizedBox(
                        height: 10,
                      ),
                      AppConstants.isdemomode == true ||
                              userDoc[Dbkeys.uSERaccountstatus] ==
                                  Dbkeys.sTATUSdeleted
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: MySimpleButton(
                                buttontext: "DELETE ACCOUNT",
                                buttoncolor: Mycolors.red,
                                onpressed: () {
                                  ShowConfirmWithInputTextDialog().open(
                                      rightbtnonpress: () async {
                                        delayedFunction(
                                            durationmilliseconds: 500,
                                            setstatefn: () async {
                                              Utils.toast(
                                                  "Deleting Account ..... Please wait !");
                                              // await ShowLoading().open(
                                              //     context: context, key: _keyLoader);
                                              if (userDoc[Dbkeys
                                                          .uSERphotourl] ==
                                                      null ||
                                                  userDoc[Dbkeys
                                                          .uSERphotourl] ==
                                                      '') {
                                              } else {
                                                await FirebaseUploader()
                                                    .deleteFile(
                                                        isDeleteUsingUrl: true,
                                                        url: userDoc[Dbkeys
                                                            .uSERphotourl],
                                                        context: context);
                                              }

                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      DbPaths.collectionusers)
                                                  .doc(
                                                      userDoc[Dbkeys.uSERphone])
                                                  .update({
                                                Dbkeys.uSERphotourl: null,
                                                Dbkeys.uSERsearchkey: '',
                                                Dbkeys.uSERfullname:
                                                    '${userDoc[Dbkeys.uSERphone]} (DELETED)',
                                                Dbkeys.uSERaccountstatus:
                                                    Dbkeys.sTATUSdeleted,
                                                Dbkeys
                                                    .uSERactionmessage: _controller
                                                            .text.length <
                                                        1
                                                    ? "Your account is deleted by Admin"
                                                    : _controller.text.trim()
                                              }).then((value) async {
                                                if (widget
                                                        .isProfileFetchedFromProvider ==
                                                    true) {
                                                  final firestore = Provider.of<
                                                          FirestoreDataProviderUSERS>(
                                                      context,
                                                      listen: false);
                                                  await firestore
                                                      .updateparticulardocinProvider(
                                                          context: context,
                                                          scaffoldkey:
                                                              _scaffoldKey,
                                                          compareKey:
                                                              Dbkeys.uSERphone,
                                                          compareVal: userDoc[
                                                              Dbkeys.uSERphone],
                                                          collection: widget
                                                              .pagecollectiontype!,
                                                          document: userDoc[
                                                              Dbkeys
                                                                  .uSERphone]);
                                                }
                                                await FirebaseFirestore.instance
                                                    .collection(widget
                                                        .pagecollectiontype!)
                                                    .doc(userDoc[
                                                        Dbkeys.uSERphone])
                                                    .get()
                                                    .then((user) {
                                                  setState(() {
                                                    userDoc = user.data();
                                                  });
                                                });
                                              }).then((value) async {
                                                Navigator.of(context).pop();
                                                // await ShowLoading().close(
                                                //     context: context,
                                                //     key: _keyLoader);
                                                // Navigator.of(context).pop();
                                                // Navigator.of(context).pop();
                                                Utils.toast(
                                                    "ACCOUNT DELETED SUCCESSFULLLY !");
                                                _controller.clear();
                                              });
                                            });
                                      },
                                      hinttext:
                                          "Mention Reason to delete. This message  will be shown to user. (Optional)",
                                      context: context,
                                      controller: _controller,
                                      title: "Delete Account",
                                      subtitle:
                                          "Delete User Account so that user cannot use this Account and would not be able to use this same Phone number again !");
                                },
                              ),
                            )
                    ],
                  ))))),
    );
  }
}
