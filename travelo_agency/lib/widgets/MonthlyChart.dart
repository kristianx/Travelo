import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/dailyStats.dart';
import '../models/reservation.dart';
import '../providers/reservation_provider.dart';

class MonthlyChart extends StatefulWidget {
  const MonthlyChart({super.key});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  late ReservationProvider _reservationProvider;
  List<DailyStats> stats = [];
  late int showingTooltip;
  DateTime selectedDate = DateTime.now();

  Future loadData() async {
    var tmpStats = await _reservationProvider.getStats(
        localStorage.getItem('agencyId') as int,
        selectedDate.month,
        selectedDate.year);
    setState(() {
      stats = tmpStats;
    });
    print(selectedDate.month);
    print(selectedDate.year);
  }

  @override
  void initState() {
    super.initState();
    showingTooltip = -1;
    _reservationProvider =
        Provider.of<ReservationProvider>(context, listen: false);
    loadData();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
          color: const Color(0xffCBCBCB),
          width: 20,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monthly stats",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff747474)),
                  ),
                  SizedBox(
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          _onPressed(context: context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF8F8F8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/calendar.svg'),
                                    const SizedBox(width: 10),
                                    if (selectedDate == null)
                                      const Text('Seleect month')
                                    else
                                      Text(DateFormat()
                                          .add_yM()
                                          .format(selectedDate)),
                                  ],
                                ),
                                SvgPicture.asset(
                                  'assets/icons/arrow-down.svg',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: AspectRatio(
                aspectRatio: 5,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                        drawHorizontalLine: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        }),
                    titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 5,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                    color: Color(0xffCECECE), fontSize: 18),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                    color: Color(0xffCECECE), fontSize: 18),
                              );
                            },
                          ),
                        )),
                    barGroups: _generateBarGroups(),
                    // [
                    //   generateGroupData(1, 10),
                    //   generateGroupData(2, 18),
                    //   generateGroupData(3, 4),
                    //   generateGroupData(4, 11),
                    // ],
                    barTouchData: BarTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        touchCallback: (event, response) {
                          if (response != null &&
                              response.spot != null &&
                              event is FlTapUpEvent) {
                            setState(() {
                              final x = response.spot!.touchedBarGroup.x;
                              final isShowing = showingTooltip == x;
                              if (isShowing) {
                                showingTooltip = -1;
                              } else {
                                showingTooltip = x;
                              }
                            });
                          }
                        },
                        mouseCursorResolver: (event, response) {
                          return response == null || response.spot == null
                              ? MouseCursor.defer
                              : SystemMouseCursors.click;
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: localeObj,
    );
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
      });
    }
    loadData();
  }

  List<BarChartGroupData> _generateBarGroups() {
    List<BarChartGroupData> list = [];
    if (stats.isNotEmpty) {
      list +=
          stats.map((e) => generateGroupData(e.date!.day, e.count!)).toList();
    }
    return list;
  }
}
