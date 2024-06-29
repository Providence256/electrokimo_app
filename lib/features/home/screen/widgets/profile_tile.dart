import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.leadingIcon,
    this.trailingIcon = const Icon(Iconsax.arrow_right_34),
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  final Widget leadingIcon, trailingIcon;
  final String title, subTitle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
