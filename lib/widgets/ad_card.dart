import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';

// For the purposes of this prototype, ad images are static
// Future consideration: Change this to a stateful widget and pull ad images from cloud storage

class AdCard extends StatelessWidget {
  static const List<String> ad_images = [
    'wellcome_ad2.jpeg',
    'wellcome_ad3.jpeg',
    'wellcome_ad4.jpeg',
    'wellcome_ad5.jpeg',
    'parknshop_ad1.png',
    'parknshop_ad2.png',
    'parknshop_ad3.png',
    'parknshop_ad4.png',
    'marketplace_ad1.jpeg',
    'marketplace_ad2.jpeg',
    'marketplace_ad3.jpeg',
    'marketplace_ad4.jpeg',
    'marketplace_ad5.jpeg',
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
                    child: Image.asset('assets/images/${ad_images[index]}'),
                  ),
                ],
              ));
        },
      ),
    ));
  }
}
