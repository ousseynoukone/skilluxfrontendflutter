import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/persistent_header.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/loader/linear_loader.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const PersistentHeader();
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
