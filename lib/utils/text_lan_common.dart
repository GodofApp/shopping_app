import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLanCommon extends Text {
  @override
  TextStyle? style;
  @override
  StrutStyle? strutStyle;
  @override
  TextAlign? textAlign;
  @override
  TextDirection? textDirection;
  @override
  Locale? locale;
  @override
  bool? softWrap;
  @override
  TextOverflow? overflow;
  @override
  double? textScaleFactor;
  @override
  int? maxLines;
  @override
  String? semanticsLabel;
  @override
  TextWidthBasis? textWidthBasis;
  @override
  TextHeightBehavior? textHeightBehavior;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;

  TextLanCommon(String data,
      {Key? key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.fontSize,
      this.fontWeight,
      this.color})
      : super(data.tr,
            style: style ?? GoogleFonts.roboto(
                    color: color ?? Colors.grey,
                    fontSize:fontSize ?? 10,
                    fontWeight:fontWeight ?? FontWeight.w400),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior);
}
