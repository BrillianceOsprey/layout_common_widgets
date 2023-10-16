import 'package:flutter/material.dart';
import 'package:layout_testing/layout_type.dart';
import 'package:layout_testing/pages/baseline_page.dart';
import 'package:layout_testing/pages/expanded_page.dart';
import 'package:layout_testing/pages/hero_page.dart';
import 'package:layout_testing/pages/list_page.dart';
import 'package:layout_testing/pages/nested_page.dart';
import 'package:layout_testing/pages/padding_page.dart';
import 'package:layout_testing/pages/page_view_page.dart';
import 'package:layout_testing/pages/row_column_page.dart';
import 'package:layout_testing/pages/slivers_page.dart';
import 'package:layout_testing/pages/stack_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  LayoutGroup _layoutGroup = LayoutGroup.nonScrollable;
  LayoutType _layoutSelection1 = LayoutType.rowColumn;
  LayoutType _layoutSelection2 = LayoutType.pageView;
  LayoutType get _layoutSelection => _layoutGroup == LayoutGroup.nonScrollable
      ? _layoutSelection1
      : _layoutSelection2;

  void _onLayoutGroupToggle() {
    setState(() {
      _layoutGroup = _layoutGroup == LayoutGroup.nonScrollable
          ? LayoutGroup.scrollable
          : LayoutGroup.nonScrollable;
    });
  }

  void _onLayoutSelected(LayoutType selection) {
    setState(() {
      if (_layoutGroup == LayoutGroup.nonScrollable) {
        _layoutSelection1 = selection;
      } else {
        _layoutSelection2 = selection;
      }
    });
  }

  void _onSelectTab(int index) {
    if (_layoutGroup == LayoutGroup.nonScrollable) {
      _onLayoutSelected(LayoutType.values[index]);
    } else {
      _onLayoutSelected(LayoutType.values[index + 5]);
    }
  }

  Color _colorTabMatching({required LayoutType layoutSelection}) {
    if (_layoutGroup == LayoutGroup.nonScrollable) {
      return _layoutSelection1 == layoutSelection ? Colors.orange : Colors.grey;
    } else {
      return _layoutSelection2 == layoutSelection ? Colors.orange : Colors.grey;
    }
  }

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required LayoutType layoutSelection,
  }) {
    String text = layoutNames[layoutSelection] ?? '';
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(layoutSelection: layoutSelection),
      ),
      label: text,
    );
  }

  Widget? _buildBody() {
    return <LayoutType, WidgetBuilder>{
      LayoutType.rowColumn: (_) => RowColumnPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.baseline: (_) => BaselinePage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.stack: (_) => StackPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.expanded: (_) => ExpandedPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.padding: (_) => PaddingPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.pageView: (_) => PageViewPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.list: (_) => ListPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.slivers: (_) => SliversPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.hero: (_) => HeroPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.nested: (_) => NestedPage(
          layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
    }[_layoutSelection]
        ?.call(context);
  }

  Widget _buildBottomNavigationBar() {
    if (_layoutGroup == LayoutGroup.nonScrollable) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(
              icon: Icons.view_headline, layoutSelection: LayoutType.rowColumn),
          _buildItem(
              icon: Icons.format_size, layoutSelection: LayoutType.baseline),
          _buildItem(icon: Icons.layers, layoutSelection: LayoutType.stack),
          _buildItem(
              icon: Icons.line_weight, layoutSelection: LayoutType.expanded),
          _buildItem(
              icon: Icons.format_line_spacing,
              layoutSelection: LayoutType.padding),
        ],
        onTap: _onSelectTab,
      );
    } else {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(
              icon: Icons.view_week, layoutSelection: LayoutType.pageView),
          _buildItem(
              icon: Icons.format_list_bulleted,
              layoutSelection: LayoutType.list),
          _buildItem(icon: Icons.view_day, layoutSelection: LayoutType.slivers),
          _buildItem(icon: Icons.gradient, layoutSelection: LayoutType.hero),
          _buildItem(icon: Icons.dashboard, layoutSelection: LayoutType.nested),
        ],
        onTap: _onSelectTab,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
