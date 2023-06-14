import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({super.key, required this.controller});

  DateRangePickerController controller;

  @override
  State<CustomDatePicker> createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  bool showPicker = false;
  DateTime? _startDate, _endDate;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                showPicker = !showPicker;
              });
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 4), // changeon of shadow
                    )
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                child: Text(
                  returnDate(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            )),
        showPicker
            ? Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    enablePastDates: false,
                    showActionButtons: true,
                    controller: widget.controller,
                    onSelectionChanged: selectionChanged,
                    // initialSelectedRange: PickerDateRange(
                    //     DateTime.now().subtract(const Duration(days: 4)),
                    //     DateTime.now().add(const Duration(days: 3))),
                    onCancel: () {
                      setState(() {
                        showPicker = false;
                      });
                    },
                    onSubmit: (p0) {
                      setState(() {
                        showPicker = false;
                      });
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    // setState(() {
    //   _startDate =
    //       DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
    //   _endDate =
    //       DateFormat('dd, MMMM yyyy').format(args.value.endDate).toString();
    // });
    setState(() {
      if (args.value is PickerDateRange) {
        _startDate = args.value.startDate;
        _endDate = args.value.endDate ?? args.value.startDate;
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
        // _dateCount = args.value.length.toString();
      }
    });
  }

  String returnDate() {
    if (_startDate != null && _endDate != null) {
      return '${DateFormat('dd. MMMM yyyy').format(_startDate!).toString()} - ${DateFormat('dd. MMMM yyyy').format(_endDate!).toString()}';
    } else {
      return 'Select date';
    }
  }
}
