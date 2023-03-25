import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/single_child_widget.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';

class MyScaffold extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final GlobalKey? scaffoldkey;
  final List<Widget>? actions;
  final Widget? body;
  final Widget? iconWidget3;
  final IconData? leadingIconData;
  final Function? leadingIconPress;
  final double? elevation;
  final IconData? icondata1;
  final Widget? iconWidget;
  final IconData? icondata2;
  final IconData? icondata3;
  final Function? icon1press;
  final double? titlespacing;
  final Function? icon2press;
  final Widget? bottom;
  final Function? icon3press;
  final Widget? floatingActionButton;
  final Color? subtitlecolor;
  final Color? iconTextColor;
  final Color? appbarColor;
  final bool? isforcehideback;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Function? onbackpressed;
  final Widget?patient;
final bool showTabBar;
  MyScaffold(

      {
      this.showTabBar=false,
      this.patient,
      this.subtitle,
      this.title,
      this.actions,
      this.iconWidget3,
      this.onbackpressed,
      this.iconWidget,
      this.iconTextColor,
      this.elevation,
      this.bottom,
      this.icon1press,
      this.titlespacing,
      this.appbarColor,
      this.icon2press,
      this.subtitlecolor,
      this.isforcehideback,
      this.icon3press,
      this.icondata1,
      this.icondata2,
      this.icondata3,
      this.leadingIconData,
      this.leadingIconPress,
      this.floatingActionButtonLocation,
      this.floatingActionButton,
      this.body,
      this.scaffoldkey});
  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    var tabBar= TabBar(
      indicatorColor: Mycolors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Mycolors.primary,
      controller: tabController,
      tabs: [
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text("Doctors"),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    
    child: Text("Patient"))
    ]);
    var tabBarView=TabBarView(
      controller: tabController,
      children: [
        widget.body??SizedBox(),
        widget.patient??SizedBox(),
      ],
    );
    return Scaffold(
      
      bottomSheet: widget.bottom ?? null,
      key: widget.scaffoldkey,
      backgroundColor: Mycolors.backgroundcolor,
      appBar: AppBar(
        leading:
            widget.isforcehideback == null || widget.isforcehideback == false
                ? IconButton(
                    onPressed: widget.leadingIconPress as void Function()? ??
                        () {
                          Navigator.pop(context);
                        },
                    icon: Icon(
                      widget.leadingIconData ?? LineAwesomeIcons.arrow_left,
                      color: widget.iconTextColor ?? Colors.black87,
                    ))
                : null,
        iconTheme: IconThemeData(
          color: widget.iconTextColor ?? Mycolors.appbartexticon,
        ),
        elevation: widget.elevation ?? 0.9,
        titleSpacing:
            widget.isforcehideback == null || widget.isforcehideback == false
                ? (widget.titlespacing ?? 0)
                : 20,
        title: widget.subtitle == null
            ? MtCustomfontBoldSemi(
                maxlines: widget.subtitle == null ? 2 : 1,
                lineheight: 1.2,
                text: widget.title ?? 'Title',
                overflow: TextOverflow.ellipsis,
                fontsize: 16.5,
                color: widget.iconTextColor ?? Mycolors.appbartexticon)
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MtCustomfontBoldSemi(
                    maxlines: 1,
                    lineheight: 1.3,
                    text: widget.title ?? 'Title',
                    overflow: TextOverflow.ellipsis,
                    fontsize: 15.5,
                    color: widget.iconTextColor ?? Mycolors.appbartexticon),
                Padding(
                    padding: const EdgeInsets.only(left: 1, top: 2),
                    child: MtCustomfontRegular(
                        maxlines: 1,
                        text: widget.subtitle ?? 'Sub-Title',
                        overflow: TextOverflow.ellipsis,
                        fontsize: 11.5,
                        color: widget.subtitlecolor ?? Mycolors.appbartexticon))
              ]),
        backgroundColor: widget.appbarColor ?? Mycolors.appbar,
        actions: widget.actions ??
            [
              Container(
                margin: EdgeInsets.only(left: 10, right: 2, bottom: 14, top: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // widget.iconWidget3 != null
                    //     ? widget.iconWidget3
                    //     : widget.icondata3 == null
                    //         ? SizedBox(
                    //             height: 0,
                    //             width: 0,
                    //           )
                    //         : Container(
                    //             margin: EdgeInsets.only(left: 0, bottom: 3),
                    //             child: IconButton(
                    //               onPressed:
                    //                   widget.icon3press as void Function()?,
                    //               icon: Icon(
                    //                 widget.icondata3 ?? Icons.done,
                    //                 size: 22,
                    //                 color: widget.iconTextColor ??
                    //                     Mycolors.appbartexticon,
                    //               ),
                    //             )),
                    widget.icondata2 == null
                        ? SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 0, bottom: 3),
                            child: IconButton(
                              onPressed: widget.icon2press as void Function()?,
                              icon: Icon(
                                widget.icondata2 ?? Icons.add,
                                size: 22,
                                color: widget.iconTextColor ??
                                    Mycolors.appbartexticon,
                              ),
                            )),
                    widget.iconWidget != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: widget.iconWidget)
                        : widget.icondata1 == null
                            ? SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 0, bottom: 3),
                                child: IconButton(
                                  onPressed:
                                      widget.icon1press as void Function()?,
                                  icon: Icon(
                                    widget.icondata1 ?? Icons.more_vert,
                                    size: 22,
                                    color: widget.iconTextColor ??
                                        Mycolors.appbartexticon,
                                  ),
                                )),
                  ],
                ),
              ),
              
            ],
            bottom: widget.isforcehideback == null || widget.isforcehideback == false? null:widget.showTabBar==true?tabBar:null,
      ),
      body: tabBarView,
      floatingActionButton: widget.floatingActionButton ?? null,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
