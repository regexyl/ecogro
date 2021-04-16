import 'package:ecogro/models/record.dart';

final allRecords = <Record>[
  Record(
    uid: '1',
    item: 'watermelon',
    name: 'Swedish Watermelon',
    quantity: 3,
    store: 'Wellcome',
    status: 'UNFINISHED',
    purchaseDate: DateTime(2021 - 04 - 15),
    expiryDate: DateTime(2021 - 04 - 15),
  ),
  Record(
    uid: '2',
    item: 'banana',
    name: 'Phili Banana',
    quantity: 2,
    store: 'PARKnSHOP',
    status: 'UNFINISHED',
    purchaseDate: DateTime(2021 - 04 - 15),
    expiryDate: DateTime(2021 - 04 - 15),
  ),
  Record(
    uid: '3',
    item: 'spinach',
    name: 'Chinese Spinach',
    quantity: 1,
    store: 'PARKnSHOP',
    status: 'UNFINISHED',
    purchaseDate: DateTime(2021 - 04 - 15),
    expiryDate: DateTime(2021 - 04 - 15),
  ),
];
