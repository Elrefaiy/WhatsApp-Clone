import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';

class EndToEndWidget extends StatelessWidget {
  final String feature;
  const EndToEndWidget({
    required this.feature,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.lock,
            size: 12,
            color: Colors.blueGrey[600],
          ),
          const SizedBox(width: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your personal $feature are ',
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontSize: 10,
                  ),
                ),
                TextSpan(
                  text: 'end-to-end encrypted',
                  style: TextStyle(
                    color: AppColors.c2(),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
