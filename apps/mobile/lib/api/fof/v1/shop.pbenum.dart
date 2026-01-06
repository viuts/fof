//
//  Generated code. Do not modify.
//  source: fof/v1/shop.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FoodCategory extends $pb.ProtobufEnum {
  static const FoodCategory FOOD_CATEGORY_UNSPECIFIED = FoodCategory._(0, _omitEnumNames ? '' : 'FOOD_CATEGORY_UNSPECIFIED');
  static const FoodCategory FOOD_CATEGORY_WASHOKU = FoodCategory._(1, _omitEnumNames ? '' : 'FOOD_CATEGORY_WASHOKU');
  static const FoodCategory FOOD_CATEGORY_SUSHI = FoodCategory._(2, _omitEnumNames ? '' : 'FOOD_CATEGORY_SUSHI');
  static const FoodCategory FOOD_CATEGORY_AGEMONO = FoodCategory._(3, _omitEnumNames ? '' : 'FOOD_CATEGORY_AGEMONO');
  static const FoodCategory FOOD_CATEGORY_YAKITORI = FoodCategory._(4, _omitEnumNames ? '' : 'FOOD_CATEGORY_YAKITORI');
  static const FoodCategory FOOD_CATEGORY_YAKINIKU = FoodCategory._(5, _omitEnumNames ? '' : 'FOOD_CATEGORY_YAKINIKU');
  static const FoodCategory FOOD_CATEGORY_NIKURYOURI = FoodCategory._(6, _omitEnumNames ? '' : 'FOOD_CATEGORY_NIKURYOURI');
  static const FoodCategory FOOD_CATEGORY_NABE = FoodCategory._(7, _omitEnumNames ? '' : 'FOOD_CATEGORY_NABE');
  static const FoodCategory FOOD_CATEGORY_DON = FoodCategory._(8, _omitEnumNames ? '' : 'FOOD_CATEGORY_DON');
  static const FoodCategory FOOD_CATEGORY_MEN = FoodCategory._(9, _omitEnumNames ? '' : 'FOOD_CATEGORY_MEN');
  static const FoodCategory FOOD_CATEGORY_RAMEN = FoodCategory._(10, _omitEnumNames ? '' : 'FOOD_CATEGORY_RAMEN');
  static const FoodCategory FOOD_CATEGORY_KONAMONO = FoodCategory._(11, _omitEnumNames ? '' : 'FOOD_CATEGORY_KONAMONO');
  static const FoodCategory FOOD_CATEGORY_YOSHOKU = FoodCategory._(12, _omitEnumNames ? '' : 'FOOD_CATEGORY_YOSHOKU');
  static const FoodCategory FOOD_CATEGORY_EUROPEAN = FoodCategory._(13, _omitEnumNames ? '' : 'FOOD_CATEGORY_EUROPEAN');
  static const FoodCategory FOOD_CATEGORY_CHINESE = FoodCategory._(14, _omitEnumNames ? '' : 'FOOD_CATEGORY_CHINESE');
  static const FoodCategory FOOD_CATEGORY_KOREAN = FoodCategory._(15, _omitEnumNames ? '' : 'FOOD_CATEGORY_KOREAN');
  static const FoodCategory FOOD_CATEGORY_ETHNIC = FoodCategory._(16, _omitEnumNames ? '' : 'FOOD_CATEGORY_ETHNIC');
  static const FoodCategory FOOD_CATEGORY_CURRY = FoodCategory._(17, _omitEnumNames ? '' : 'FOOD_CATEGORY_CURRY');
  static const FoodCategory FOOD_CATEGORY_IZAKAYA = FoodCategory._(18, _omitEnumNames ? '' : 'FOOD_CATEGORY_IZAKAYA');
  static const FoodCategory FOOD_CATEGORY_BAR = FoodCategory._(19, _omitEnumNames ? '' : 'FOOD_CATEGORY_BAR');
  static const FoodCategory FOOD_CATEGORY_CAFE = FoodCategory._(20, _omitEnumNames ? '' : 'FOOD_CATEGORY_CAFE');
  static const FoodCategory FOOD_CATEGORY_SWEETS = FoodCategory._(21, _omitEnumNames ? '' : 'FOOD_CATEGORY_SWEETS');

  static const $core.List<FoodCategory> values = <FoodCategory> [
    FOOD_CATEGORY_UNSPECIFIED,
    FOOD_CATEGORY_WASHOKU,
    FOOD_CATEGORY_SUSHI,
    FOOD_CATEGORY_AGEMONO,
    FOOD_CATEGORY_YAKITORI,
    FOOD_CATEGORY_YAKINIKU,
    FOOD_CATEGORY_NIKURYOURI,
    FOOD_CATEGORY_NABE,
    FOOD_CATEGORY_DON,
    FOOD_CATEGORY_MEN,
    FOOD_CATEGORY_RAMEN,
    FOOD_CATEGORY_KONAMONO,
    FOOD_CATEGORY_YOSHOKU,
    FOOD_CATEGORY_EUROPEAN,
    FOOD_CATEGORY_CHINESE,
    FOOD_CATEGORY_KOREAN,
    FOOD_CATEGORY_ETHNIC,
    FOOD_CATEGORY_CURRY,
    FOOD_CATEGORY_IZAKAYA,
    FOOD_CATEGORY_BAR,
    FOOD_CATEGORY_CAFE,
    FOOD_CATEGORY_SWEETS,
  ];

  static final $core.Map<$core.int, FoodCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FoodCategory? valueOf($core.int value) => _byValue[value];

  const FoodCategory._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
