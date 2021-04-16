import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecogro/widgets/search_widget.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecogro/models/record.dart';
import 'package:ecogro/mock_data.dart';

class RecordsList extends StatefulWidget {
  @override
  _RecordsListState createState() => _RecordsListState();
}

class _RecordsListState extends State<RecordsList> {
  List<Record> records;
  String query = '';

  @override
  void initState() {
    super.initState();
    records = allRecords; // retrieve list from firebase here
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 80.0,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Your food items',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ],
              )),
              Container(
                height: 20.0,
              ),
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return buildRecord(record);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Item or Store Name',
        onChanged: searchRecord,
      );

  Widget buildRecord(Record record) => Container(
    margin: EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Constants.primaryColor, width: 3),
      color: Colors.green[100]
    ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: SizedBox(
          height: 50,
          width: 50,
          child: SvgPicture.asset('assets/svg/${record.item}.svg'),
        ),
        title: Text('${record.name}'),
        subtitle: Text('${record.store}\nBought on ${DateFormat('yyyy-MM-dd').format(record.purchaseDate)}'),
        trailing: Text('${record.quantity.toString()}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Constants.primaryColor),),
      ));

  void searchRecord(String query) {
    final records = allRecords.where((record) {
      final nameLower = record.name.toLowerCase();
      final storeLower = record.store.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          storeLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.records = records;
    });
  }
}
