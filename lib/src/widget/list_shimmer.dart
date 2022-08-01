import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: List<Widget>.generate(3, (int index) => Expanded(child: _item(context))),
      ),
    );
  }

  Widget _item(BuildContext context) {
    return Container(
      width: 150,
      height: 350,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.red,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
    );
  }
}
