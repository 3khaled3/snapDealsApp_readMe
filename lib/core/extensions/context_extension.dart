import 'package:flutter/material.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';

extension Localization on BuildContext {
  Tr get tr => Tr.of(this);
}
