import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final text = context.localizations;
    final TextTheme textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: 1,
              child: Container(
                color: colorScheme.secondary,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.library_books,
                    ),
                    Text(
                      text.publication,
                      style: textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              )),
          AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: 1 - progress,
              child: Container(
                decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    border: BorderDirectional(
                        bottom: BorderSide(
                            color: colorScheme.onPrimary, width: 0.3),
                        top: BorderSide(
                            color: colorScheme.onPrimary, width: 0.3))),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.library_books,
                    ),
                    Text(
                      text.publication,
                      style: textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 27;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
