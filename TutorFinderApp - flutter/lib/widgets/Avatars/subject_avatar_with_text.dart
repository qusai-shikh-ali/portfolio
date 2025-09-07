import 'package:flutter/material.dart';

class SubjectAvatarWithTextLabel extends StatelessWidget {
  const SubjectAvatarWithTextLabel({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            child: Icon(icon),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          )
        ],
      ),
    );
  }
}
