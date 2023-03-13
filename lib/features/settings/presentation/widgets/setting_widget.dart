import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';

class SettingWidget extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;
  final String hint;

  const SettingWidget({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.c5(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    hint,
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
