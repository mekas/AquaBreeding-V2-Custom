import 'package:fish/models/activation_model.dart';
import 'package:fish/models/feed_history_detail.dart';
import 'package:fish/models/feed_history_hourly.dart';
import 'package:fish/models/feed_history_monthly.dart';
import 'package:fish/models/feed_history_weekly.dart';
import 'package:fish/models/pond_model.dart';
import 'package:flutter/material.dart';

import 'package:fish/theme.dart';

class FeedHourCard extends StatelessWidget {
  final Activation? activation;
  final Pond? pond;
  final FeedHistoryMonthly? feedHistoryMonthly;
  final FeedHistoryWeekly? feedHistoryWeekly;
  final FeedHistoryDaily? feedHistoryDaily;
  final FeedHistoryHourly? feedHistoryHourly;

  const FeedHourCard(
      {Key? key,
      this.activation,
      this.pond,
      this.feedHistoryMonthly,
      this.feedHistoryWeekly,
      this.feedHistoryDaily,
      this.feedHistoryHourly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        // padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor),
          color: transparentColor,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal :',
                    style: headingText3,
                  ),
                  Text(
                    feedHistoryHourly!.getDate(),
                    style: headingText3,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Pakan",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "${feedHistoryHourly!.brandName}",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Waktu",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        feedHistoryHourly!.getTime(),
                        style: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pakan",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "${feedHistoryHourly!.totalFeedWeight} Kg",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
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
