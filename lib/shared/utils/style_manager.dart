import 'package:flutter/material.dart';
import 'package:socialite/shared/utils/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color,
    double? height, FontStyle? fontStyle) {
  return TextStyle(
      fontFamily: FontConstant.fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: height,
      fontStyle: fontStyle);
}

TextStyle _getRobotoTextStyle(double fontSize, FontWeight fontWeight,
    Color color, double? height, FontStyle? fontStyle) {
  return TextStyle(
      fontFamily: FontConstant.robotoFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: height,
      fontStyle: fontStyle);
}

// Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color, height, fontStyle);
}

// Medium Style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getTextStyle(
      fontSize, FontWeightManager.medium, color, height, fontStyle);
}

// Light Style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getTextStyle(
      fontSize, FontWeightManager.light, color, height, fontStyle);
}

// Semi-Bold Style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getTextStyle(
      fontSize, FontWeightManager.semiBold, color, height, fontStyle);
}

// Bold Style
TextStyle getBoldStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getTextStyle(
      fontSize, FontWeightManager.bold, color, height, fontStyle);
}

// Regular Style
TextStyle getRegularRobotoStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getRobotoTextStyle(
      fontSize, FontWeightManager.regular, color, height, fontStyle);
}

// Medium Style
TextStyle getMediumRobotoStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getRobotoTextStyle(
      fontSize, FontWeightManager.medium, color, height, fontStyle);
}

// Light Style
TextStyle getLightRobotoStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getRobotoTextStyle(
      fontSize, FontWeightManager.light, color, height, fontStyle);
}

// Bold Style
TextStyle getBoldRobotoStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? height,
    FontStyle? fontStyle}) {
  return _getRobotoTextStyle(
      fontSize, FontWeightManager.bold, color, height, fontStyle);
}
