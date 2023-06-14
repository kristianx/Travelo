import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MonthPicker extends StatefulWidget {
  MonthPicker({
    super.key,
    required this.selectedDate,
  });
  DateTime? selectedDate;

  @override
  State<MonthPicker> createState() => MonthPickerState();
}

class MonthPickerState extends State<MonthPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onPressed(context: context);
      },
      child: SizedBox(
        width: 150,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/calendar.svg'),
                const SizedBox(width: 10),
                if (widget.selectedDate == null)
                  const Text('Seleect month')
                else
                  Text(DateFormat().add_yM().format(widget.selectedDate!)),
              ],
            ),
          ),
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
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: localeObj,
    );
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: widget.selectedDate ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        widget.selectedDate = selected;
      });
    }
  }
}
