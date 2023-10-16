import 'package:flutter/material.dart';
import 'package:layout_testing/layout_type.dart';

class SliversPage extends StatelessWidget implements HasLayoutGroup {
  const SliversPage({
    Key? key,
    required this.layoutGroup,
    required this.onLayoutToggle,
  }) : super(key: key);

  @override
  final LayoutGroup layoutGroup;
  @override
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            expandedHeight: 120.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Slivers'),
            ),
            leading: IconButton(
              icon: Icon(layoutGroup == LayoutGroup.nonScrollable
                  ? Icons.filter_1
                  : Icons.filter_2),
              onPressed: onLayoutToggle,
            )),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('grid item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}
