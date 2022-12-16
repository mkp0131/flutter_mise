import 'package:flutter/material.dart';
import 'package:flutter_mise/component/card_title.dart';
import 'package:flutter_mise/component/main_card.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/utils/data_utils.dart';
import 'package:hive_flutter/adapters.dart';

class HourlyCard extends StatelessWidget {
  final Color lightColor;
  final Color darkColor;
  final ItemCode itemCode;
  final String region;

  const HourlyCard({
    required this.lightColor,
    required this.darkColor,
    required this.itemCode,
    required this.region,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MainCard(
        backgroundColor: lightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitle(
              title: '시간별 ${DataUtils.getItemCodeKrString(itemCode: itemCode)}',
              backgroundColor: darkColor,
            ),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<StatModel>(itemCode.name).listenable(),
                builder: (context, box, widget) {
                  final statList = box.values.toList().reversed;
                  return Column(
                    children:
                        statList.map((stat) => renderRow(stat: stat)).toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget renderRow({
    required StatModel stat,
  }) {
    final status = DataUtils.getStatusFromItemCodeAndValue(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('${stat.dataTime.hour}시')),
          SizedBox(
            width: 25,
            child: Image.asset(status.imagePath),
          ),
          Expanded(
              child: Text(
            status.label,
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }
}
