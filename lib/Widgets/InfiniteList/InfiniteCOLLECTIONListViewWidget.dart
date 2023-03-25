import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreCOLLECTIONDataProvider.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Widgets/noDataWidget.dart';

class InfiniteCOLLECTIONListViewWidget extends StatefulWidget {
  final FirestoreDataProviderUSERS? firestoreDataProviderUSERS;
  final FirestoreDataProviderREPORTS? firestoreDataProviderREPORTS;
  final FirestoreDataProviderCALLHISTORY? firestoreDataProviderCALLHISTORY;
  final String? datatype;
  final Widget? list;
  final Query? refdata;
  final bool? isreverse;
  final EdgeInsets? padding;
  final String? parentid;
  const InfiniteCOLLECTIONListViewWidget({
    this.firestoreDataProviderUSERS,
    this.firestoreDataProviderCALLHISTORY,
    this.firestoreDataProviderREPORTS,
    this.datatype,
    this.isreverse,
    this.padding,
    this.parentid,
    this.list,
    this.refdata,
    Key? key,
  }) : super(key: key);

  @override
  _InfiniteCOLLECTIONListViewWidgetState createState() =>
      _InfiniteCOLLECTIONListViewWidgetState();
}

class _InfiniteCOLLECTIONListViewWidgetState
    extends State<InfiniteCOLLECTIONListViewWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);
    if (widget.datatype == Dbkeys.dataTypeUSERS) {
      widget.firestoreDataProviderUSERS!
          .fetchNextData(widget.datatype, widget.refdata, true);
    } else if (widget.datatype == Dbkeys.dataTypeCALLHISTORY) {
      widget.firestoreDataProviderCALLHISTORY!
          .fetchNextData(widget.datatype, widget.refdata, true);
    } else if (widget.datatype == Dbkeys.dataTypeREPORTS) {
      widget.firestoreDataProviderREPORTS!
          .fetchNextData(widget.datatype, widget.refdata, true);
    } else {}
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (widget.datatype == Dbkeys.dataTypeUSERS) {
        if (widget.firestoreDataProviderUSERS!.hasNext) {
          widget.firestoreDataProviderUSERS!
              .fetchNextData(widget.datatype, widget.refdata, false);
        }
      } else if (widget.datatype == Dbkeys.dataTypeCALLHISTORY) {
        if (widget.firestoreDataProviderCALLHISTORY!.hasNext) {
          widget.firestoreDataProviderCALLHISTORY!
              .fetchNextData(widget.datatype, widget.refdata, false);
        }
      } else if (widget.datatype == Dbkeys.dataTypeREPORTS) {
        if (widget.firestoreDataProviderREPORTS!.hasNext) {
          widget.firestoreDataProviderREPORTS!
              .fetchNextData(widget.datatype, widget.refdata, false);
        }
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      reverse:
          widget.isreverse == null || widget.isreverse == false ? false : true,
      controller: scrollController,
      padding: widget.padding == null ? EdgeInsets.all(0) : widget.padding,
      children: (widget.datatype == Dbkeys.dataTypeUSERS ||
              widget.datatype == Dbkeys.dataTypeSTAFFS ||
              widget.datatype == Dbkeys.dataTypePARTNERS)
          ?
          //-----USERS
          [
              Container(child: widget.list),
              (widget.firestoreDataProviderUSERS!.hasNext == true)
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          widget.firestoreDataProviderUSERS!.fetchNextData(
                              widget.datatype, widget.refdata, false);
                        },
                        child: Padding(
                          padding: widget.firestoreDataProviderUSERS!
                                      .recievedDocs.length ==
                                  0
                              ? EdgeInsets.fromLTRB(
                                  38,
                                  MediaQuery.of(context).size.height / 3,
                                  38,
                                  38)
                              : const EdgeInsets.all(18.0),
                          child: Container(child: circularProgress()),
                        ),
                      ),
                    )
                  : widget.firestoreDataProviderUSERS!.recievedDocs.length < 1
                      ? noDataWidget(
                          padding: EdgeInsets.fromLTRB(28,
                              MediaQuery.of(context).size.height / 3.7, 28, 10),
                          title: 'No Users',
                        )
                      : SizedBox(),
            ]
          : (widget.datatype == Dbkeys.dataTypeCALLHISTORY)
              ?
              //-----USERS
              [
                  Container(child: widget.list),
                  (widget.firestoreDataProviderCALLHISTORY!.hasNext == true)
                      ? Center(
                          child: GestureDetector(
                            onTap: () {
                              widget.firestoreDataProviderCALLHISTORY!
                                  .fetchNextData(
                                      widget.datatype, widget.refdata, false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Mycolors.loadingindicator),
                                ),
                              ),
                            ),
                          ),
                        )
                      : widget.firestoreDataProviderCALLHISTORY!.recievedDocs
                                  .length <
                              1
                          ? noDataWidget(
                              padding: EdgeInsets.fromLTRB(
                                  28,
                                  MediaQuery.of(context).size.height / 7.7,
                                  28,
                                  10),
                              title: 'No Call history',
                              iconData: Icons.phone,
                              iconColor: Mycolors.primary,
                              subtitle: '')
                          : SizedBox(),
                ]
              : (widget.datatype == Dbkeys.dataTypeREPORTS)
                  ?
                  //-----USERS
                  [
                      Container(child: widget.list),
                      (widget.firestoreDataProviderREPORTS!.hasNext == true)
                          ? Center(
                              child: GestureDetector(
                                onTap: () {
                                  widget.firestoreDataProviderREPORTS!
                                      .fetchNextData(widget.datatype,
                                          widget.refdata, false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Mycolors.loadingindicator),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : widget.firestoreDataProviderREPORTS!.recievedDocs
                                      .length <
                                  1
                              ? noDataWidget(
                                  padding: EdgeInsets.fromLTRB(
                                      28,
                                      MediaQuery.of(context).size.height / 7.7,
                                      28,
                                      10),
                                  title: 'No Reports sent by users',
                                  iconData: Icons.report,
                                  iconColor: Mycolors.primary,
                                  subtitle: '')
                              : SizedBox(),
                    ]
                  :
                  //----- COUPON
                  []);
}
