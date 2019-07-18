import 'dart:math';

import 'package:decimal/decimal.dart';

class BaseCommon {
  static const String homeBanner = 'HomeBeanner';
  static const String homeCoin = "HomeCoinTag";
  static const String iamgeUri = 'https://vbt.oss-cn-hongkong.aliyuncs.com/';

  static Decimal setScale(
      Decimal decimal, int scale, Decimal roundMethod(Decimal decimal)) {
    Decimal scaleVal = Decimal.fromInt(pow(10, scale));
    return roundMethod(decimal * scaleVal) / scaleVal;
  }

  static Decimal setScaleRoundDown(Decimal decimal, int scale) =>
      setScale(decimal, scale, (val) => val.floor());

  static Decimal setScaleRoundUp(Decimal decimal, int scale) =>
      setScale(decimal, scale, (val) => val.ceil());

  static Decimal setScaleRound(Decimal decimal, int scale) =>
      setScale(decimal, scale, (val) => val.round());


}
