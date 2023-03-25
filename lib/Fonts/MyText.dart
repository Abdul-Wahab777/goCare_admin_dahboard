import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

// ignore: todo
//TODO--------- Custom font Texts---(Your Fav font in Popular languages)-------

class MtPoppinsLight extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtPoppinsLight(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtPoppinsLightState createState() => _MtPoppinsLightState();
}

class _MtPoppinsLightState extends State<MtPoppinsLight> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 10,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            fontSize: widget.fontsize ?? 12,
            color: widget.color ?? Mycolors.greylightcolor,
            height: widget.lineheight ?? 1,
            fontFamily: 'Poppins-Light',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtPoppinsBold extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final double? spacing;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtPoppinsBold(
      {this.text,
      this.isitalic,
      this.weight,
      this.spacing,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtPoppinsBoldState createState() => _MtPoppinsBoldState();
}

class _MtPoppinsBoldState extends State<MtPoppinsBold> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 10,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            letterSpacing: widget.spacing ?? null,
            fontSize: widget.fontsize ?? 12,
            color: widget.color ?? Mycolors.black,
            height: widget.lineheight ?? 1,
            fontFamily: 'Poppins-Bold',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtPoppinsExtraBold extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtPoppinsExtraBold(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtPoppinsExtraBoldState createState() => _MtPoppinsExtraBoldState();
}

class _MtPoppinsExtraBoldState extends State<MtPoppinsExtraBold> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 10,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            fontSize: widget.fontsize ?? 12,
            color: widget.color ?? Mycolors.greylightcolor,
            height: widget.lineheight ?? 1,
            fontFamily: 'Poppins-ExtraBold',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtPoppinsSemiBold extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtPoppinsSemiBold(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtPoppinsSemiBoldState createState() => _MtPoppinsSemiBoldState();
}

class _MtPoppinsSemiBoldState extends State<MtPoppinsSemiBold> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 10,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            fontSize: widget.fontsize ?? 12,
            color: widget.color ?? Mycolors.greylightcolor,
            height: widget.lineheight ?? 1,
            fontFamily: 'Poppins-SemiBold',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtPoppinsRegular extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtPoppinsRegular(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtPoppinsRegularState createState() => _MtPoppinsRegularState();
}

class _MtPoppinsRegularState extends State<MtPoppinsRegular> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 10,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            fontSize: widget.fontsize ?? 12,
            color: widget.color ?? Mycolors.greylightcolor,
            height: widget.lineheight ?? 1,
            fontFamily: 'Poppins-Regular',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

// ignore: todo
//TODO--------- Custom font Texts---(Your Fav font in Popular languages)-------

class MtCustomfontLight extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtCustomfontLight(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtCustomfontLightState createState() => _MtCustomfontLightState();
}

class _MtCustomfontLightState extends State<MtCustomfontLight> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 10,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            fontSize: widget.fontsize ?? 12,
            color: widget.color ?? Mycolors.greylightcolor,
            height: widget.lineheight ?? 1,
            fontFamily: 'Soleil-Light',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtCustomfontRegular extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtCustomfontRegular(
      {this.text,
      this.isitalic,
      this.weight,
      this.decoration,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtCustomfontRegularState createState() => _MtCustomfontRegularState();
}

class _MtCustomfontRegularState extends State<MtCustomfontRegular> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 1000,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            decoration: widget.decoration ?? null,
            fontSize: widget.fontsize ?? 16,
            color: widget.color ?? Mycolors.grey,
            height: widget.lineheight ?? 1,
            fontFamily: 'Soleil-Regular',
            fontWeight: widget.weight ?? FontWeight.normal,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtCustomfontMedium extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final double? spacing;
  final bool? isitalic;
  final Color? color;

  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtCustomfontMedium(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.spacing,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtCustomfontMediumState createState() => _MtCustomfontMediumState();
}

class _MtCustomfontMediumState extends State<MtCustomfontMedium> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 1000,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            letterSpacing: widget.spacing ?? null,
            fontSize: widget.fontsize ?? 14,
            color: widget.color ?? Mycolors.black,
            height: widget.lineheight ?? 1,
            fontFamily: 'Soleil-Medium',
            fontWeight: widget.weight ?? FontWeight.w600,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtCustomfontBold extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final double? letterspacing;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtCustomfontBold(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.letterspacing,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtCustomfontBoldState createState() => _MtCustomfontBoldState();
}

class _MtCustomfontBoldState extends State<MtCustomfontBold> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 1000,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            letterSpacing: widget.letterspacing ?? null,
            fontSize: widget.fontsize ?? 20,
            color: widget.color ?? Mycolors.black,
            height: widget.lineheight ?? 1,
            fontFamily: 'Soleil-Bold',
            fontWeight: widget.weight ?? FontWeight.w700,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtCustomfontBoldExtra extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  MtCustomfontBoldExtra(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtCustomfontBoldExtraState createState() => _MtCustomfontBoldExtraState();
}

class _MtCustomfontBoldExtraState extends State<MtCustomfontBoldExtra> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 1000,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            fontSize: widget.fontsize ?? 18,
            color: widget.color ?? Mycolors.black,
            height: widget.lineheight ?? 1,
            fontFamily: 'Soleil-ExtraBold',
            fontWeight: widget.weight ?? FontWeight.w800,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}

class MtCustomfontBoldSemi extends StatefulWidget {
  final String? text;
  final double? lineheight;
  final double? fontsize;
  final bool? isitalic;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextDirection? textdirection;
  final TextAlign? textalign;
  final int? maxlines;
  final double? letterspacing;
  MtCustomfontBoldSemi(
      {this.text,
      this.isitalic,
      this.weight,
      this.color,
      this.fontsize,
      this.letterspacing,
      this.lineheight,
      this.textdirection,
      this.overflow,
      this.maxlines,
      this.textalign});
  @override
  _MtCustomfontBoldSemiState createState() => _MtCustomfontBoldSemiState();
}

class _MtCustomfontBoldSemiState extends State<MtCustomfontBoldSemi> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text ?? 'Text',
        textDirection: widget.textdirection ?? TextDirection.ltr,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: widget.maxlines ?? 1000,
        textAlign: widget.textalign ?? TextAlign.left,
        style: TextStyle(
            letterSpacing: widget.letterspacing ?? null,
            fontSize: widget.fontsize ?? 18,
            color: widget.color ?? Mycolors.black,
            height: widget.lineheight ?? 1,
            fontWeight: widget.weight ?? FontWeight.w600,
            fontStyle:
                widget.isitalic == true ? FontStyle.italic : FontStyle.normal));
  }
}
