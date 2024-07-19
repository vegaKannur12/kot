// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:restaurent_kot/Screen/itemlistpage.dart';
// import 'package:restaurent_kot/controller/controller.dart';

// class CatTEST extends StatefulWidget {
//   String? tablId;
//   String? roomId;
//   CatTEST({super.key, required this.tablId, required this.roomId});

//   @override
//   State<CatTEST> createState() => _CatTESTState();
// }

// class _CatTESTState extends State<CatTEST> 
// {
//   TextEditingController seacrh = TextEditingController();
//   String? date;
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<Controller>(context, listen: false).getIDss();
//     });
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   Provider.of<Controller>(context, listen: false).getCategoryList(context);
//     //   //tempry adding qty
//     // });
//     date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 // Provider.of<Controller>(context, listen: false).viewCart(
//                 //   context,
//                 //   value.customerId.toString(),
//                 // );
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               )),
//           backgroundColor: Color.fromARGB(255, 139, 200, 228),
//           // Theme.of(context).primaryColor,

//           actions: [
//             Consumer<Controller>(
//               builder: (context, value, child) => Card(
//                 shape: const StadiumBorder(),
//                 color: Colors.black,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     "${value.tabl_name.toString().toUpperCase()} / ${value.room_nm.toString().toUpperCase() == "" || value.room_nm.toString().toUpperCase().isEmpty || value.room_nm.toString().toUpperCase() == "NULL" ? "" : value.room_nm.toString().toUpperCase()} /${value.cart_id.toString()}",
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         body: Consumer<Controller>(
//           builder: (context, value, child) => Row(
//             children: [
//               Container(
//                 width: size.width * 1 / 3,
//                 color: Colors.amber,
//                 child:  Consumer<Controller>(
//         builder: (context, value, child) => Column(
//           children: [
//             TextFormField(
//               controller: seacrh,
//               //   decoration: const InputDecoration(,
//               onChanged: (val) {
//                 Provider.of<Controller>(context, listen: false)
//                     .searchCat(val.toString());
//               },
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(
//                   Icons.search,
//                   color: Colors.black,
//                 ),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.cancel),
//                   onPressed: () {
//                     seacrh.clear();
//                     Provider.of<Controller>(context, listen: false)
//                         .searchCat("");
//                   },
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide:
//                       const BorderSide(color: Colors.blue, width: 1.0),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide:
//                       const BorderSide(color: Colors.black, width: 1.0),
//                 ),
//                 hintText: "Search Category...",
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             value.isSearch
//                 ? categoryWidget(size, value.filteredlist,
//                     value.tabl_ID.toString(), value.room_ID.toString())
//                 : categoryWidget(size, value.catlist,
//                     value.tabl_ID.toString(), value.room_ID.toString())
//           ],
//         ),
//                   ),
        
        
//               ),
//               Expanded(
//                 child: Container(
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
//  Widget categoryWidget(Size size, List list, String tbl, String rm) {
//     return Consumer<Controller>(
//       builder: (context, value, child) => value.isCategoryLoading
//           ? const Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: SpinKitCircle(
//                   color: Colors.black,
//                 ),
//               ),
//             )
//           : Expanded(
//               child: list.isEmpty
//                   ? const Center(child: Text("no data"))
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       physics: const ScrollPhysics(),
//                       itemCount: value.isSearch
//                           ? value.filteredlist.length
//                           : value.catlist.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 1,
//                               crossAxisSpacing: 12,
//                               childAspectRatio: 1.5,
//                               mainAxisSpacing: 12),
//                       itemBuilder: (context, index) => InkWell(
//                         onTap: () {
//                           value.setCatID(
//                               list[index]["Cat_Id"].toString().trimLeft(),
//                               context);
//                           Provider.of<Controller>(context, listen: false)
//                               .getItemList(context);
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => ItemList(
//                           //             catlId: list[index]["Cat_Id"],
//                           //             catName: list[index]["Cat_Name"],
//                           //             // tablId: tbl,roomId: rm,
//                           //           )),
//                           // );
//                         },
//                         child: Card(
//                           color: Colors.grey[200],
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 alignment: Alignment.center,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 8.0, bottom: 8),
//                                   child: Center(
//                                     child: Text(
//                                       maxLines: 2,
//                                       list[index]["Cat_Name"]
//                                           .toString()
//                                           .trimLeft()
//                                           .toUpperCase(),
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//             ),
//     );
//   }

