
import 'package:path/path.dart';
import 'package:restaurent_kot/model/registration_model.dart';

import 'package:sqflite/sqflite.dart';

class KOT {
  static final KOT instance = KOT._init();
  static Database? _database;
  KOT._init();
  //////////////////////////////////////

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("kot.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(
      path,
      version: 1, onCreate: _createDB,
      // onUpgrade: _upgradeDB
    );
  }

  Future _createDB(Database db, int version) async {
    ///////////////barcode store table ////////////////
    await db.execute('''
          CREATE TABLE companyRegistrationTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cid TEXT NOT NULL,
            fp TEXT NOT NULL,
            os TEXT NOT NULL,
            type TEXT,
            app_type TEXT,
            cpre TEXT,
            ctype TEXT,
            cnme TEXT,
            ad1 TEXT,
            ad2 TEXT,
            ad3 TEXT,
            pcode TEXT,
            land TEXT,
            mob TEXT,
            em TEXT,
            gst TEXT,
            ccode TEXT,
            scode TEXT,
            msg TEXT
          )
          ''');
/////////////////////order bag//////////////////////////////////////////////
    // await db.execute('''
    //       CREATE TABLE orderBagTable (
    //         id INTEGER PRIMARY KEY AUTOINCREMENT,
    //         itemName TEXT NOT NULL,
    //         catId TEXT NOT NULL,
    //         cartDate TEXT,
    //         cartTime TEXT,
    //         os TEXT NOT NULL,
    //         customerId TEXT,
    //         cartRowno INTEGER,
    //         code TEXT,
    //         qty REAL,
    //         rate TEXT,
    //         totalAmount TEXT,
    //         pid INTEGER,
    //         unitName TEXT,
    //         package REAL,
    //         baseRate REAL,
    //         cStatus INTEGER
    //       )
    //       ''');
/////////////////////order master///////////////////////////////////////////
    await db.execute('''
          CREATE TABLE orderMasterTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            orderDate TEXT,
            orderTime TEXT,
            catId TEXT NOT NULL,
            os TEXT NOT NULL,
            customerId TEXT,
            userId TEXT,
            areaId TEXT,
            status INTEGER,
            totalPrice REAL
          )
          ''');
////////////////////////////order detail//////////////////////////////////////////////
    await db.execute('''
          CREATE TABLE orderDetailTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item TEXT,
            os TEXT NOT NULL,
            orderId INTEGER,
            rowNum INTEGER,
            code TEXT,
            qty INTEGER,
            unit TEXT,
            rate REAL,
            packing TEXT,
            baseRate REAL  
          )
          ''');
          await db.execute('''
          CREATE TABLE orderBagtable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,       
            tableId INTEGER,
            catId INTEGER,
            pname TEXT,
            rate REAL,
            qty INTEGER        
          )
          ''');
  }



 Future insertorderBagTab(String tableId,Map data,double qty) async {
    final db = await database;
    var query ='INSERT INTO orderBagtable(tableId,catId,pname,rate,qty) VALUES("$tableId", "${data["catid"]}" , "${data["pname"]}", "${data["rate"]}","$qty")';
    var res = await db.rawInsert(query);
    print(query);
    print("inserted to bag  ----$res");
    return res;
  }

/////////////////////////////////////////////////////////////////////////
  Future insertRegistrationDetails(RegistrationData data) async {
    final db = await database;
    var query1 =
        'INSERT INTO companyRegistrationTable(cid, fp, os, type, app_type, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, msg) VALUES("${data.cid}", "${data.fp}", "${data.os}","${data.type}","${data.apptype}","${data.c_d![0].cpre}", "${data.c_d![0].ctype}", "${data.c_d![0].cnme}", "${data.c_d![0].ad1}", "${data.c_d![0].ad2}", "${data.c_d![0].ad3}", "${data.c_d![0].pcode}", "${data.c_d![0].land}", "${data.c_d![0].mob}", "${data.c_d![0].em}", "${data.c_d![0].gst}", "${data.c_d![0].ccode}", "${data.c_d![0].scode}", "${data.msg}" )';
    var res = await db.rawInsert(query1);
    print(query1);
    print("registered ----$res");
    return res;
  }

////////////////////////////////////////////////////////////////////////////////
   deleteFromTableCommonQuery(String table, String? condition) async {
    // ignore: avoid_print
    print("table--condition -$table---$condition");
    Database db = await instance.database;
    if (condition == null || condition.isEmpty || condition == "") {
      // ignore: avoid_print
      print("no condition");
      await db.delete('$table');
    } else {
      // ignore: avoid_print
      print("condition");

      await db.rawDelete('DELETE FROM "$table" WHERE $condition');
    }
  }

///////////////////////////////////////////////////////////////////////////////
  selectCommonQuery(String table, String? condition, String fields) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var query = "SELECT $fields FROM '$table' $condition";
    result = await db.rawQuery(query);
    print("naaknsdJK-----$result");
    return result;
  }

  ///////////////////////////////////////////////////////////////////////////
  updateCommonQuery(String table, String fields, String condition) async {
    Database db = await instance.database;
    var query = 'UPDATE $table SET $fields $condition ';
    var res = await db.rawUpdate(query);
    return res;
  }

  ///////////////////////////////////////////////////////////////////////////
  getMaxCommonQuery(String table, String field, String? condition) async {
    var res;
    int max;
    Database db = await instance.database;
    var result = await db.rawQuery("SELECT * FROM '$table'");
    if (result.isNotEmpty) {
      var query = "SELECT MAX($field) max_val FROM '$table'";
      res = await db.rawQuery(query);
      max = res[0]["max_val"] + 1;
    } else {
      max = 1;
    }
    return max;
  }

  //////////////////////////////////////////////////////////////////////
  Future insertorderBagTable(
    String itemName,
    String catId,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    double rate,
    double totalamount,
    int pid,
    String unit_name,
    String packagenm,
    double baseRate,
    int cstatus,
  ) async {
    print("qty--$qty");
    print("unit_name........$customerid...$unit_name");
    final db = await database;

    var query2 =
        'INSERT INTO orderBagTable (itemName,catId, cartDate, cartTime , os, customerId, cartRowno, code, qty, rate, totalAmount, pid, unitName, package, baseRate, cStatus) VALUES ("${itemName}","${catId}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, $rate, $totalamount,  $pid, "$unit_name", "$packagenm", $baseRate, $cstatus)';
    var res = await db.rawInsert(query2);

    // ignore: avoid_print
    print("insert query result $res");

    return res;
  }

  //////////////////////////////////////////////////////////
  Future insertorderMasterandDetailsTable(
    String item,
    int order_id,
    double? qty,
    double rate,
    String? code,
    String orderdate,
    String ordertime,
    String os,
    String customerid,
    String userid,
    String areaid,
    int status,
    String? unit,
    int rowNum,
    String table,
    double total_price,
    double? packing,
    double? base_rate,
  ) async {
    final db = await database;
    var res2;

    if (table == "orderDetailTable") {
      var query2 =
          'INSERT INTO orderDetailTable(orderId, rowNum,os,code, item, qty, rate, unit, packing, baseRate) VALUES(${order_id},${rowNum},"${os}","${code}","${item}", ${qty}, $rate, "${unit}", $packing, $base_rate)';
      // ignore: avoid_print
      print(query2);
      res2 = await db.rawInsert(query2);
    } else if (table == "orderMasterTable") {
      var query3 =
          'INSERT INTO orderMasterTable(orderId, orderDate, orderTime, os, customerId, userId, areaId, status, totalPrice) VALUES("${order_id}", "${orderdate}", "${ordertime}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status},${total_price})';
      res2 = await db.rawInsert(query3);
      // ignore: avoid_print
      print(query3);
    }
  }

  /////////////////////////////////////////////////////////////
  getListOfTables() async {
    Database db = await instance.database;
    var list = await db.query('sqlite_master', columns: ['type', 'name']);
    print(list);
    list.map((e) => print(e["name"])).toList();
    return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  getTableData(String tablename) async {
    Database db = await instance.database;
    print(tablename);
    var list = await db.rawQuery('SELECT * FROM $tablename');
    print(list);
    return list;
    // list.map((e) => print(e["name"])).toList();
    // return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  ///////////////////////////................................///////////////////////////////////////
  


}
