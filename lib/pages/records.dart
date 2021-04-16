import 'package:flutter/material.dart';
import 'package:ecogro/widgets/search_widget.dart';
import 'package:ecogro/utils/constants.dart';
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
      body: Column(
        children: <Widget>[
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
    );
    
    Widget buildSearch() => SearchWidget(
          text: query,
          hintText: 'Item or Store Name',
          onChanged: searchRecord,
        );

    Widget buildRecord(Record record) => ListTile(
        // leading: Image.asset('assets/images/${record.item}.*'), // can it end with *?
        title: Text(record.item),
        subtitle: Text(record.store),
      );

  void searchRecord(String query) {
    final records = allRecords.where((record) {
      final itemLower = record.item.toLowerCase();
      final storeLower = record.store.toLowerCase();
      final searchLower = query.toLowerCase();

      return itemLower.contains(searchLower) ||
          storeLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.records = records;
    });
  }
}

