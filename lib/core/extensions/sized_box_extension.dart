import 'package:flutter/material.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

//todo add sized box with height 15
// 15.ph
//todo add sized box with width 20
// 20.pw
//todo add sized box with height 20 mop and 30 tap
//  RM.data.mapSize(mobile: 20, tablet:30).ph;

