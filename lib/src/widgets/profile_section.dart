import 'package:flutter/material.dart';

/// A profile section widget for sidebar footer
class ProfileSection extends StatelessWidget {
  final String name;
  final String? subtitle;
  final String? imageUrl;
  final Widget? avatar;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;

  const ProfileSection({
    super.key,
    required this.name,
    this.subtitle,
    this.imageUrl,
    this.avatar,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBorderColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF0F2F4);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: borderColor ?? defaultBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _buildAvatar(context),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF617589),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (avatar != null) return avatar!;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: Colors.grey[300],
      );
    }

    // Default avatar with first letter
    final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey[300],
      child: Text(
        firstLetter,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}
