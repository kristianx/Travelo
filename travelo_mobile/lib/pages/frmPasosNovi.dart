import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelo_mobile/model/pasos.dart';
import 'package:travelo_mobile/model/user.dart';
import 'package:travelo_mobile/pages/frmPasosi.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/providers/pasosi_provider.dart';
import 'package:travelo_mobile/providers/user_provider.dart';
import 'package:travelo_mobile/widgets/CustomDatePicker.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';

class frmPasosiNovi extends StatefulWidget {
  const frmPasosiNovi({super.key});

  @override
  State<frmPasosiNovi> createState() => _frmPasosiNoviState();
}

class _frmPasosiNoviState extends State<frmPasosiNovi> {
  late PasosProvider _pasosiProvider;
  late UserProvider _userProvider;
  final DateRangePickerController _datePickerController =
      DateRangePickerController();
  final formKey = GlobalKey<FormState>();
  int _value = -1;
  List<User> users = [];
  bool? validno = false;
  // List<DropdownMenuItem> usersDropdown = [
  //   const DropdownMenuItem(
  //     value: -1,
  //     enabled: false,
  //     child: Text("Loading..."),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _pasosiProvider = context.read<PasosProvider>();
    _userProvider = context.read<UserProvider>();

    loadData();
  }

  Future loadData() async {
    var tmpUsers = await _userProvider.get();
    setState(() {
      users = tmpUsers;
    });
    // _updateUsersDropdown();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text("Dodaj novi pasos"),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
            CheckboxListTile(
              title: Text("Da li je validan?"),
              value: validno,
              onChanged: (newValue) {
                setState(() {
                  validno = newValue;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            SimpleButton(
              onTap: () async {
                print(_datePickerController.selectedDate);
                print(validno);
                print(_value);
                if (_datePickerController.selectedDate != null &&
                    validno != null &&
                    _value != -1 &&
                    _value != -2) {
                  try {
                    var addedFlag = await _pasosiProvider.insert({
                      "dateIssued":
                          _datePickerController.selectedDate.toString(),
                      "userId": _value,
                      "valid": validno,
                    });

                    if (addedFlag != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => frmPasosi()));
                    }
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text("Error"),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ));
                  }
                }
              },
              bgColor: const Color(0xffEAAD5F),
              textColor: Colors.white,
              text: "Dodaj",
              width: 300,
              height: 70,
            ),
          ],
        ),
      ),
    );
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
  // void _updateUsersDropdown() {
  //   if (users.isNotEmpty) {
  //     List<DropdownMenuItem> list = [];
  //     list.add(const DropdownMenuItem(
  //       value: -2,
  //       enabled: false,
  //       child: Text(
  //         "Choose user",
  //         style: TextStyle(color: Color(0xff999999)),
  //       ),
  //     ));
  //     list += users
  //         .map((e) {
  //           return DropdownMenuItem(
  //             value: e.id,
  //             child: Text("${e.firstName} ${e.lastName}"),
  //           );
  //         })
  //         .cast<DropdownMenuItem>()
  //         .toList();
  //     setState(() {
  //       usersDropdown = list;
  //     });
  //   }
  // }
  // List<Widget> _buildPasosi() {
  //   if (pasosi.isEmpty) {
  //     //Add loading for few seconds and if no data then text.
  //     return [const Text("There are no pasosi.")];
  //   }
  //   List<Widget> list = pasosi
  //       .map((x) => Row(
  //             children: [
  //               Text(x.userName ?? ""),
  //               Text(x.dateIssued.toString()),
  //               Text(x.valid.toString()),
  //             ],
  //           ))
  //       .cast<Widget>()
  //       .toList();
  //   return list;
  // }
}
