import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';

// For the purposes of this prototype, ad images are static
// Future consideration: Change this to a stateful widget and pull ad images from cloud storage

class AdCard extends StatelessWidget {
  static const List<String> ad_images = [
    'wellcome_ad2',
    'wellcome_ad3',
    'wellcome_ad4',
    'wellcome_ad5',
    'parknshop_ad1',
    'parknshop_ad2',
    'parknshop_ad3',
    'parknshop_ad4',
    'marketplace_ad1',
    'marketplace_ad2',
    'marketplace_ad3',
    'marketplace_ad4',
    'marketplace_ad5',
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      // height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: 6),
        itemCount: ad_images.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(right: 10),
              width: 270,
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset('assets/images/${ad_images[index]}.jpeg'),
                  ),
                ],
              ));
        },
      ),
    ));
  }
}
