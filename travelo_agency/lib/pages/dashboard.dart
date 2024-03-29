import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/main.dart';
import 'package:travelo_agency/models/reservation.dart';
import 'package:travelo_agency/providers/reservation_provider.dart';
import 'package:travelo_agency/widgets/MonthlyChart.dart';
import '../models/dailyStats.dart';
import '../utils/util.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ReservationProvider _reservationProvider;
  List<Reservation> reservations = [];
  List<DailyStats> stats = [];
  String sales = "-";
  String customers = "-";
  String bookings = "-";
  String offers = "-";
  late int showingTooltip;
  DateTime selectedDate = DateTime.now();

  Future updateStats() async {
    setState(() {});
  }

  Future loadData() async {
    var tmpData = await _reservationProvider
        .get({'agencyId': localStorage.getItem('agencyId')});
    var tmpStats = await _reservationProvider.getStats(
        localStorage.getItem('agencyId') as int,
        selectedDate.month,
        selectedDate.year);
    setState(() {
      reservations = tmpData;
      stats = tmpStats;
      sales = reservations
          .fold(0, (previousValue, element) => previousValue + element.price!)
          .toString();
      customers = reservations
          .fold(
              0,
              (previousValue, element) =>
                  previousValue +
                  element.numberOfAdults! +
                  element.numberOfChildren!)
          .toString();
      bookings = reservations.length.toString();
      offers = reservations.length.toString();
    });
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: _buildStatCards()),
          const SizedBox(height: 20),
          MonthlyChart(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 35),
            child: Center(
                child: Text(
              "Bookings",
              style: TextStyle(fontSize: 25, color: Color(0xff747474)),
            )),
          ),
          Center(
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: _buildTableRows()),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  List<Widget> _buildStatCards() {
    return [
      Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(children: [
            SvgPicture.asset("assets/icons/total-sales.svg"),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$$sales",
                  style: const TextStyle(
                      color: Color(0xff747474),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Total sales",
                  style: TextStyle(
                      color: Color(0xffCBCBCB),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ],
            )
          ]),
        ),
      ),
      Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(children: [
            SvgPicture.asset("assets/icons/total-customers.svg"),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customers,
                  style: const TextStyle(
                      color: Color(0xff747474),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Total customers",
                  style: TextStyle(
                      color: Color(0xffCBCBCB),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ],
            )
          ]),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 4), // changes position of shadow
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(children: [
            SvgPicture.asset("assets/icons/total-bookings.svg"),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookings,
                  style: const TextStyle(
                      color: Color(0xff747474),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Total bookings",
                  style: TextStyle(
                      color: Color(0xffCBCBCB),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ],
            )
          ]),
        ),
      ),
      Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(children: [
            SvgPicture.asset("assets/icons/total-offers.svg"),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offers,
                  style: const TextStyle(
                      color: Color(0xff747474),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Total offers",
                  style: TextStyle(
                      color: Color(0xffCBCBCB),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ],
            )
          ]),
        ),
      ),
    ];
  }

  List<TableRow> _buildTableRows() {
    List<TableRow> list = [];
    list.add(const TableRow(
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Color(0xffCBCBCB)))),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Date",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Image",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Accomodation",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Destination",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Period",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Adults+Children",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              "Price",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
        ]));
    if (reservations.isEmpty) {
      list.add(const TableRow(children: [
        Center(),
        Center(),
        Center(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text("There are no bookings.")),
        ),
        Center(),
        Center(),
        Center(),
      ]));
    } else {
      list += reservations
          .map((re) => TableRow(children: [
                Center(
                    child: Text(DateFormat('dd. MMMM yyyy')
                        .format(re.timeOfReservation!))),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: re.destinationImage == ""
                                  ? const AssetImage(
                                      'assets/images/imageHolder.png')
                                  : imageFromBase64String(
                                          re.destinationImage ?? "")
                                      .image,
                              fit: BoxFit.cover),
                        )),
                  ),
                ),
                Center(child: Text(re.accomodationName ?? "-")),
                Center(child: Text("${re.destinationName}, ${re.countryName}")),
                Center(child: Text(
                    // "${DateFormat('dd. MMMM').format(re.checkIn!)} - ${DateFormat('dd. MMMM yyyy').format(re.checkOut!)}"
                    re.date ?? "-")),
                Center(
                    child:
                        Text("${re.numberOfAdults} + ${re.numberOfChildren}")),
                Center(
                    child: Text(
                  "\$${re.price}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )),
              ]))
          .toList();
    }
    return list;
  }
}
