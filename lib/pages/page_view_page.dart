import 'package:flutter/material.dart';
import 'package:layout_testing/layout_type.dart';
import 'package:layout_testing/pages/main_app_bar.dart';

class PageViewPage extends StatelessWidget implements HasLayoutGroup {
  const PageViewPage({
    Key? key,
    required this.layoutGroup,
    required this.onLayoutToggle,
  }) : super(key: key);

  @override
  final LayoutGroup layoutGroup;
  @override
  final VoidCallback onLayoutToggle;

  Widget _buildPage({required int index, required Color color}) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: color,
      child: Text(
        '$index',
        style: const TextStyle(fontSize: 132.0, color: Colors.white),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      children: [
        _buildPage(index: 1, color: Colors.green),
        _buildPage(index: 2, color: Colors.blue),
        _buildPage(index: 3, color: Colors.indigo),
        _buildPage(index: 4, color: Colors.red),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: layoutGroup,
        layoutType: LayoutType.pageView,
        onLayoutToggle: onLayoutToggle,
      ),
      body: _buildPageView(),
    );
  }
}
