import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/models/bestAccomodations.dart';
import 'package:travelo_agency/models/bestCustomers.dart';
import '../main.dart';
import '../providers/reservation_provider.dart';
import '../utils/util.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReservationProvider _reservationProvider;
  List<BestCustomers> bestCustomers = [];
  List<BestAccomodations> bestAccomodations = [];

  Future loadData() async {
    var tmpData = await _reservationProvider
        .getBestCustomers(localStorage.getItem('agencyId'));
    var tmpAcc = await _reservationProvider
        .getBestAccomodations(localStorage.getItem('agencyId'));

    setState(() {
      bestCustomers = tmpData;
      bestAccomodations = tmpAcc;
    });
  }

  @override
  void initState() {
    super.initState();
    _reservationProvider =
        Provider.of<ReservationProvider>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 35),
          child: Center(
              child: Text(
            "Best customers",
            style: TextStyle(fontSize: 25, color: Color(0xff747474)),
          )),
        ),
        Center(
          child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: _buildTableRows()),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 35),
          child: Center(
              child: Text(
            "Best accomodations",
            style: TextStyle(fontSize: 25, color: Color(0xff747474)),
          )),
        ),
        Center(
          child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: _buildAccomodationsTableRows()),
        ),
        const SizedBox(height: 100),
      ],
    );
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
              "User Name",
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
              "Number of trips",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
        ]));
    if (bestCustomers.isEmpty) {
      list.add(const TableRow(children: [
        Center(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text("There are no accomodations.")),
        ),
        Center(),
      ]));
    } else {
      list += bestCustomers
          .map((re) => TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: re.image == "" || re.image == null
                                  ? const AssetImage(
                                      'assets/images/imageHolder.png')
                                  : imageFromBase64String(re.image ?? "").image,
                              fit: BoxFit.cover),
                        )),
                  ),
                ),
                Center(child: Text(re.customerName ?? "-")),
                Center(child: Text(re.numberOfTrips.toString())),
              ]))
          .toList();
    }
    return list;
  }

  List<TableRow> _buildAccomodationsTableRows() {
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
              "Accomodation Name",
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
              "Total earnings",
              style: TextStyle(
                  color: Color(0xff292929),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          ),
        ]));
    if (bestAccomodations.isEmpty) {
      list.add(const TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text("There are no bookings.")),
        ),
        Center(),
      ]));
    } else {
      list += bestAccomodations
          .map((re) => TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(child: Text(re.accommodationName ?? "-")),
                ),
                Center(child: Text("\$${re.totalPrice.toString()}")),
              ]))
          .toList();
    }
    return list;
  }
}
