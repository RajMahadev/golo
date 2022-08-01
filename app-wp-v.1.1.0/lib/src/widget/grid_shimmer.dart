import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmer extends StatelessWidget {
  const GridShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        crossAxisCount: 2,
        childAspectRatio: 0.715,
        children: List.generate(10, (index) {
          return _item();
        }));
  }

  Widget _item() {
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
