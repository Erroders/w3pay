import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalletCard extends StatefulWidget {
  final int? color;
  final String address;
  final double balance;

  const WalletCard({
    Key? key,
    this.color,
    required this.address,
    required this.balance,
  }) : super(key: key);

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  @override
  Widget build(BuildContext context) {
    String smallAddress = "0000";
    if (widget.address.length > 6) {
      smallAddress =
          widget.address.substring(widget.address.length - 4).toUpperCase();
    }

    return AspectRatio(
      aspectRatio: 1.586,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28.0),
        decoration: ShapeDecoration(
          color: widget.color != null
              ? Color(widget.color!).withOpacity(0.9)
              : Colors.blueAccent.withOpacity(0.9),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 20,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/svgs/wallet.svg',
                  width: 60,
                  height: 60,
                  color: Colors.white,
                ),
                Text(
                  "**** $smallAddress",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "\$${widget.balance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
