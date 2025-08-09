import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  final String titleText, subtitleText;
  final IconData leadingIcon, trailingIcon;

  const CustomListTileWidget({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        subtitleText,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: Icon(trailingIcon),
    );
  }
}
