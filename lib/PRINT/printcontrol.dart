import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkPrinter {
  testTicket(List printlist) async {
    print("rrrr---$printlist");
    // [
    //   {
    //     "Cart_ID": 12,
    //     "Cart_date": "2024-08-01 00:00:00.0",
    //     "Cart_Salesman_ID": "VGMHD3",
    //     "Cart_Table_ID": "VGMHD8",
    //     "Cart_Room_ID": 15,
    //     "Cart_Guest_Info": "SIRISHA",
    //     "Cart_Qty": 1.0000,
    //     "Cart_Rate": 100.0000,
    //     "It_Total": 100.0000,
    //     "Prod_Name": "CHEESE SANDWICH",
    //   },
    //   {
    //     "Cart_ID": 12,
    //     "Cart_date": "2024-08-01 00:00:00.0",
    //     "Cart_Salesman_ID": "VGMHD3",
    //     "Cart_Table_ID": "VGMHD8",
    //     "Cart_Room_ID": 15,
    //     "Cart_Guest_Info": "SIRISHA",
    //     "Cart_Qty": 2.0000,
    //     "Cart_Rate": 20.0000,
    //     "It_Total": 40.0000,
    //     "Prod_Name": "TEA",
    //   }
    // ];
    // final printer = PrinterNetworkManager('192.168.18.100');
    // PosPrintResult connect = await printer.connect();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("heloo test");
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.text('KOT',
        styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.row([
      PosColumn(
        text: 'Date & Time',
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: printlist[0]["Cart_date"].toString().trimLeft(),
        width: 8,
        styles: const PosStyles(align: PosAlign.left),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: "KOT No : ${printlist[0]["Cart_Table_ID"].toString().trimLeft()}",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "Room# : ${printlist[0]["Cart_Room_ID"].toString().trimLeft()}",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
    ]);
    bytes += generator.text('Waiter :',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Customer Details',
        styles: const PosStyles(underline: true, align: PosAlign.left),
        linesAfter: 1);
    bytes += generator.text(
        printlist[0]["Cart_Guest_Info"].toString().trimLeft(),
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.row([
      PosColumn(
        text: 'Sl#',
        width: 3,
        styles: const PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: 'ITEM NAME',
        width: 6,
        styles: const PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: 'QTY',
        width: 3,
        styles: const PosStyles(align: PosAlign.left, underline: true),
      ),
    ]);
    for (int i = 0; i < printlist.length; i++) {
      bytes += generator.row([
        PosColumn(
          text: '${i + 1}',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: printlist[i]["Prod_Name"].toString().trimLeft().toUpperCase(),
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: printlist[i]["Cart_Qty"].toStringAsFixed(2),
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ]);
    }

/////////////////////////////////
    // bytes += generator.text(
    //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: const PosStyles(codeTable: 'CP1252'));
    // bytes += generator.text('Special 2: blåbærgrød',
    //     styles: const PosStyles(codeTable: 'CP1252'));

    // bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    // bytes +=
    //     generator.text('Reverse text', styles: const PosStyles(reverse: true));
    // bytes += generator.text('Underlined text',
    //     styles: const PosStyles(underline: true), linesAfter: 1);
    // bytes += generator.text('Align left',
    //     styles: const PosStyles(align: PosAlign.left));
    // bytes += generator.text('Align center',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += generator.text('Align right',
    //     styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    // bytes += generator.row([
    //   PosColumn(
    //     text: 'col3',
    //     width: 3,
    //     styles: const PosStyles(align: PosAlign.center, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'col6',
    //     width: 6,
    //     styles: const PosStyles(align: PosAlign.center, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'col3',
    //     width: 3,
    //     styles: const PosStyles(align: PosAlign.center, underline: true),
    //   ),
    // ]);

    // bytes += generator.text('Text size 200%',
    //     styles: const PosStyles(
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //     ));

    // // Print barcode
    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.feed(2);
    bytes += generator.cut();
    await printTicket(bytes);
    // return bytes;
  }

  printTicket(List<int> ticket) async {
    print("heloo prin");
    final printer = PrinterNetworkManager('192.168.18.245');
    PosPrintResult connect = await printer.connect();
    if (connect == PosPrintResult.success) {
      print("heloo prin 22");
      PosPrintResult printing = await printer.printTicket(ticket);
      print(printing.msg);
      printer.disconnect();
    }
  }
}
