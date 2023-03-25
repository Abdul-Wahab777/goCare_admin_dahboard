import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Services/providers/FirestoreDOCUMENTDataProvider.dart';

class InfiniteDOCUMENTListViewWidget extends StatefulWidget {
  final FirestoreDataProviderDocNOTIFICATION?
      firestoreDataProviderDocNOTIFICATION;
  final String? datatype;
  final Widget? list;
  final bool? isreverse;
  final String? catcode;
  final DocumentReference? refdata;
  final EdgeInsets? padding;
  const InfiniteDOCUMENTListViewWidget({
    this.firestoreDataProviderDocNOTIFICATION,
    this.datatype,
    this.list,
    this.padding,
    this.isreverse,
    this.catcode,
    this.refdata,
    Key? key,
  }) : super(key: key);

  @override
  _InfiniteDOCUMENTListViewWidgetState createState() =>
      _InfiniteDOCUMENTListViewWidgetState();
}

class _InfiniteDOCUMENTListViewWidgetState
    extends State<InfiniteDOCUMENTListViewWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.datatype == Dbkeys.dataTypeNOTIFICATIONS) {
      widget.firestoreDataProviderDocNOTIFICATION!
          .fetchLISTDOCUMENT(widget.datatype, widget.refdata, true);
    } else {}
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse:
          widget.isreverse == false || widget.isreverse == null ? false : true,
      controller: scrollController,
      padding: EdgeInsets.all(0),
      children: [
        Container(child: widget.list),
        widget.firestoreDataProviderDocNOTIFICATION!.listmap!.length < 1
            ? Align(
                alignment: Alignment.center,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        28, MediaQuery.of(context).size.height / 3.7, 28, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(20),
                              // ),
                            ),
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/coupon2.png',
                              color: Mycolors.cyan.withOpacity(0.98),
                              height: 30,
                              width: 30,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'No Notifications',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Mycolors.black.withOpacity(0.9),
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You have not recieved any Notifications yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Mycolors.black.withOpacity(0.4),
                              fontSize: 13.9,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
