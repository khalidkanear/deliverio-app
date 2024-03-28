import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../Constants.dart';

List<Color> gradientColors = [
  kBase.withOpacity(.5),
  kBase.withOpacity(.5),
];

LineChartData mainData(double maxEarning, List<FlSpot> spots) {
  DateTime today = DateTime.now();

  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 16);
              String text;
              switch (value.toInt()) {
                case 2:
                  text = "MAR";
                  break;
                case 5:
                  text = 'JUN';
                  break;
                case 8:
                  text = 'SEP';
                  break;
                default:
                  text = '';
              }

              return Text(text, style: style, textAlign: TextAlign.center);
            },
            // getTextStyles: (value) => const TextStyle(
            //     color: Color(0xff68737d),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16),
            // getTitles: (value) {
            //   switch (value.toInt()) {
            //     case 2:
            //       return 'MAR';
            //     case 5:
            //       return 'JUN';
            //     case 8:
            //       return 'SEP';
            //   }
            //   return '';
            // },
            // margin: 8,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: Color(0xff67727d),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              );
              String text;
              switch (value.toInt()) {
                case 1:
                  text = '10k';
                  break;
                case 3:
                  text = '30k';
                  break;
                case 5:
                  text = '50k';
                  break;
                default:
                  text = '';
              }

              return Text(text, style: style, textAlign: TextAlign.center);
            },

            // getTextStyles: (value) => const TextStyle(
            //   color: Color(0xff67727d),
            //   fontWeight: FontWeight.bold,
            //   fontSize: 15,
            // ),
            // getTitles: (value) {
            //   switch (value.toInt()) {
            //     case 1:
            //       return '10k';
            //     case 3:
            //       return '30k';
            //     case 5:
            //       return '50k';
            //   }
            //   return '';
            // },
            reservedSize: 28,
            // margin: 12,
          ),
        )),
    borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 30,
    minY: 0,
    maxY: maxEarning + 500,
    lineBarsData: [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        // colors: gradientColors,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          // color:
          //     gradientColors.map((color) => color.withOpacity(0.2)).toList(),
        ),
      ),
    ],
  );
}

LineChartData avgData() {
  return LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 16);
              String text;
              switch (value.toInt()) {
                case 2:
                  text = 'MAR';
                  break;
                case 5:
                  text = 'JUN';
                  break;
                case 8:
                  text = 'SEP';
                  break;
                default:
                  text = '';
              }

              return Text(text, style: style, textAlign: TextAlign.center);
            },
            // getTextStyles: (value) => const TextStyle(
            //     color: Color(0xff68737d),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16),
            // getTitles: (value) {
            //   switch (value.toInt()) {
            //     case 2:
            //       return 'MAR';
            //     case 5:
            //       return 'JUN';
            //     case 8:
            //       return 'SEP';
            //   }
            //   return '';
            // },
            // margin: 8,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 16);
              String text;
              switch (value.toInt()) {
                case 1:
                  text = '10k';
                  break;
                case 3:
                  text = '30k';
                  break;
                case 5:
                  text = '50k';
                  break;
                default:
                  text = '';
              }

              return Text(text, style: style, textAlign: TextAlign.center);
            },

            // getTextStyles: (value) => const TextStyle(
            //   color: Color(0xff67727d),
            //   fontWeight: FontWeight.bold,
            //   fontSize: 15,
            // ),
            // getTitles: (value) {
            //   switch (value.toInt()) {
            //     case 1:
            //       return '10k';
            //     case 3:
            //       return '30k';
            //     case 5:
            //       return '50k';
            //   }
            //   return '';
            // },
            reservedSize: 28,
            // margin: 12,
          ),
        )),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          const FlSpot(0, 3.44),
          const FlSpot(2.6, 3.44),
          const FlSpot(4.9, 3.44),
          const FlSpot(6.8, 3.44),
          const FlSpot(8, 3.44),
          const FlSpot(9.5, 3.44),
          const FlSpot(11, 3.44),
        ],
        isCurved: true,

        // colors: [
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
        //       .lerp(0.2),
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
        //       .lerp(0.2),
        // ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          //  colors: [
          //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //       .lerp(0.2)
          //       .withOpacity(0.1),
          //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //       .lerp(0.2)
          //       .withOpacity(0.1),
          // ]
        ),
      ),
    ],
  );
}
