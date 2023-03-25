import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/features/home/domain/entities/status.dart';

import '../../../../core/utils/app_colors.dart';

class StatusWidget extends StatelessWidget {
  final List<Status> status;
  final String name;
  const StatusWidget({
    required this.status,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.status,
          arguments: status,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            DashedCircle(
              dashes: status.length,
              gapSize: 3,
              color: AppColors.c2(),
              child: status.last.isImage
                  ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          status.last.status,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: Color(status.last.color),
                        radius: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            status.last.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    // ignore: unrelated_type_equality_checks
                    '${status.last.dateTime.substring(0, 10)}, ${status.last.dateTime.substring(11, 16)}',
                    style: Theme.of(context).textTheme.bodyText2,
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
