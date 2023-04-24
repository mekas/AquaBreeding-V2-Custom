import 'package:flutter/material.dart';

import 'package:fish/theme.dart';

class StatisticCard extends StatelessWidget {
  final String? title;
  final num? value;
  final String? unit;

  const StatisticCard(
      {Key? key, this.title = '', this.value = 0, this.unit = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: defaultMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xffECEDEF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      value!.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      unit!,
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: medium,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
