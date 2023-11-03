import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuddybrewLogo extends StatelessWidget {
  final double size;

  const BuddybrewLogo({super.key, this.size = 100});

  final String assetName = 'assets/buddybrew_logo_blue.svg';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size,
      width: size,
    );
  }
}
