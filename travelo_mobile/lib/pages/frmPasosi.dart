import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelo_mobile/model/pasos.dart';
import 'package:travelo_mobile/model/user.dart';
import 'package:travelo_mobile/pages/frmPasosNovi.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/providers/pasosi_provider.dart';
import 'package:travelo_mobile/providers/user_provider.dart';
import 'package:travelo_mobile/widgets/CustomDatePicker.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';

class frmPasosi extends StatefulWidget {
  const frmPasosi({super.key});

  @override
  State<frmPasosi> createState() => _frmPasosiState();
}

class _frmPasosiState extends State<frmPasosi> {
  late PasosProvider _pasosiProvider;
  List<Pasos> pasosi = [];
  late UserProvider _userProvider;
  final DateRangePickerController _datePickerController =
      DateRangePickerController();
  List<User> users = [];
  int _value = -1;

  @override
  void initState() {
    super.initState();
    _pasosiProvider = context.read<PasosProvider>();
    _userProvider = context.read<UserProvider>();

    loadData();
  }

  Future loadData() async {
    var tmpPasosi = await _pasosiProvider.get({});
    var tmpUsers = await _userProvider.get();
    setState(() {
      pasosi = tmpPasosi;
      users = tmpUsers;
    });
  }

  Future filterData() async {
    print(_value);
    print(_datePickerController.selectedDate.toString());
    var tmpPasosi = await _pasosiProvider.get({
      'dateIssued': _datePickerController.selectedDate.toString(),
      'userId': _value
    });
    var tmpUsers = await _userProvider.get();
    setState(() {
      pasosi = tmpPasosi;
      users = tmpUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text('frmPasosi'),
          const SizedBox(
            height: 20,
          ),
          SimpleButton(
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => frmPasosiNovi()));
            },
            bgColor: const Color(0xffEAAD5F),
            textColor: Colors.white,
            text: "Novi pasos",
            width: 300,
            height: 70,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Filteri',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: DropdownButtonFormField(
                    value: _value,
                    items: _buildUserItemsDropDownList(),
                    onChanged: (v) {
                      _value = v;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                        child: SvgPicture.asset(
                          "assets/icons/Planet.svg",
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          CustomDatePicker(controller: _datePickerController),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                filterData();
              },
              child: Text(
                'Filteriraj',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffEAAD5F)),
              )),
          // const SizedBox(
          //   height: 20,
          // ),
          // SimpleButton(
          //   onTap: () async {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => frmPasosiNovi()));
          //   },
          //   bgColor: const Color(0xffEAAD5F),
          //   textColor: Colors.white,
          //   text: "Novi pasos",
          //   width: 300,
          //   height: 70,
          // ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: _buildPasosi(),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPasosi() {
    if (pasosi.isEmpty) {
      //Add loading for few seconds and if no data then text.
      return [const Text("There are no pasosi.")];
    }
    List<Widget> list = pasosi
        .map((x) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(x.userName ?? ""),
                Text(x.dateIssued.toString()),
                Text(x.valid.toString()),
              ],
            ))
        .cast<Widget>()
        .toList();
    return list;
  }

  List<DropdownMenuItem> _buildUserItemsDropDownList() {
    List<DropdownMenuItem> list = [];
    if (users.isEmpty) {
      list.add(const DropdownMenuItem(
        value: -1,
        enabled: false,
        child: Text("Loading..."),
      ));
      return list;
    }

    list.add(const DropdownMenuItem(
      value: -1,
      enabled: false,
      child: Text("Choose user"),
    ));
    list += users
        .map((user) => DropdownMenuItem(
              value: user.id,
              child: Text("${user.firstName} ${user.lastName}"),
            ))
        .cast<DropdownMenuItem>()
        .toList();
    return list;
  }
}
