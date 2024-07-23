import 'package:flutter/material.dart';

class PopupMenuButtonComponent extends StatelessWidget {
  final List<CustomPopupMenuItem> menuItems;
  final Widget? icon;

  const PopupMenuButtonComponent({
    super.key,
    required this.menuItems,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: icon ?? const Icon(Icons.more_vert),
      onSelected: (String value) {
        final selectedItem = menuItems.firstWhere((item) => item.value == value);
        selectedItem.onTap();
      },
      itemBuilder: (BuildContext context) {
        return menuItems.map((item) {
          return PopupMenuItem(
            value: item.value,
            child: Row(
              children: [
                if (item.icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: item.icon!,
                  ),
                Text(item.text),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}

class CustomPopupMenuItem {
  final String value;
  final String text;
  final Icon? icon;
  final VoidCallback onTap;

  CustomPopupMenuItem({
    required this.value,
    required this.text,
    this.icon,
    required this.onTap,
  });
}