import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../controller/controller.dart';

class DateFind {
  DateTime currentDate = DateTime.now();

  // String? formattedDate;
  String? fromDate;
  String? toDate;
  String? crntDateFormat;
  String? specialField;
  String? gen_condition;
  DateTime? sdate;
  DateTime? ldate;

  Future selectDateFind(BuildContext context, String dateType) async {
    sdate = Provider.of<Controller>(context, listen: false).sdate;
    ldate = Provider.of<Controller>(context, listen: false).ldate;
    print("date-0--------${sdate!.day}----${sdate!.month}-----${sdate!.year}");
    crntDateFormat = DateFormat('dd-MMM-yyyy').format(currentDate);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(sdate!.year, sdate!.month, sdate!.day),
        lastDate: DateTime(ldate!.year, ldate!.month, ldate!.day),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light()
                    .copyWith(primary: Theme.of(context).primaryColor),
              ),
              child: child!);
        });
    if (pickedDate != null) {
      // setState(() {
      currentDate = pickedDate;
      // });
    } else {
      print("please select date");
    }

    if (dateType == "from date") {
      print("curnt date----$currentDate");
      fromDate = DateFormat('dd-MMM-yyyy').format(currentDate);
      // fromDate = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(currentDate);
      // fromDate = DateFormat(DateFormat.).format(currentDate);

      if (toDate == null) {
        toDate = DateFormat('dd-MMM-yyyy')
            .format(Provider.of<Controller>(context, listen: false).d);
      }
    }
    if (dateType == "to date") {
      toDate = DateFormat('dd-MMM-yyyy').format(currentDate);
      if (fromDate == null) {
        fromDate = DateFormat('dd-MMM-yyyy')
            .format(Provider.of<Controller>(context, listen: false).d);
      }
    }
    print("fromdate-----$fromDate---$toDate");
    // Provider.of<Controller>(context, listen: false).fromDate=fromDate;
    if (fromDate != null && toDate != null) {
      Provider.of<Controller>(context, listen: false)
          .setDate(fromDate!, toDate!);
    }
    toDate = toDate == null
        ? Provider.of<Controller>(context, listen: false).todate.toString()
        : toDate.toString();
  }
}
