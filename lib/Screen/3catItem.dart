import 'package:azlistview/azlistview.dart';

class ItemList extends ISuspensionBean{

  final String title;
  final String tag;


  ItemList({required this.title, required this.tag});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return tag;
  }

}