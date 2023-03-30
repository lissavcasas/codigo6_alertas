import 'package:codigo6_alertas/ui/general.dart';
import 'package:flutter/material.dart';

Center loadingWidget = Center(
  child: SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      strokeWidth: 2.4,
      color: kBrandPrimaryColor,
    ),
  ),
);
